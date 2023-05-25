class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_form_variables, only: %i[ new edit ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @task = Task.new
    @statuses = Task.statuses
  end

  # GET /tasks/1 or /tasks/1.json
  def show
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
    redirect_to tasks_path, notice: "Task was successfully destroyed."
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
end
