class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_changes_count
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_form_variables, only: %i[ new edit ]

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks.order(priority: :asc)
    @statuses = Task.statuses
    @priorities = {
      all: Task.priorities.keys,
      checked: Task.priorities.keys,
    }

    @filter_opened = params[:filter_opened] ? JSON.parse(params[:filter_opened]) : false
    if params[:priorities]
      priorities = JSON.parse(params[:priorities])
      @tasks = @tasks.with_priority(priorities);
      @priorities[:checked] = priorities
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/1/logs
  def logs
    @task = Task.find(params[:task_id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    current_user.tasks << @task

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    set_changes_count
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Task was successfully destroyed." }
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :status, :priority, :user_id)
    end

    def set_form_variables
      @statuses = Task.statuses.keys.map { |status| [status.humanize, status]}
      @priorities = Task.priorities.keys.map { |priority| [priority.humanize, priority]}
      @users = User.pluck(:first_name, :id)
    end

    def set_changes_count
      now = Time.zone.now

      @changes_count = Audited::Audit.where(
        user_id: current_user.id, 
        created_at: now.beginning_of_day..now.end_of_day
      ).count
    end
end
