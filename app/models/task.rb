class Task < ApplicationRecord
  scope :with_status, ->(status) { where(status:) }
  scope :with_priority, ->(priority) { where(priority:) }

  enum status: { to_do: 0, in_progress: 1, review: 2, done: 3, cancelled: 4 }
  enum priority: { high: 0, normal: 1, low: 2 }
  
  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :priority, presence: true, inclusion: { in: priorities.keys }
  validates :user, presence: true

  after_create_commit { broadcast_append_to('tasks') }

  audited

  def logs_humanized
    self.audits
      .reorder(created_at: :desc)
      .pluck(:id, :created_at, :action, :audited_changes)
      .map do |(id, created_at, action, audited_changes)|
      {
        id:,
        created_at:,
        action: action.humanize,
        audited_changes: self.logs_humanize!(audited_changes),
      }
    end 
  end

  private

  def logs_humanize! audited_changes
    audited_changes.map do |column_name, content|
      if content.kind_of?(Array)
        (from, to) = content
        from = log_fields_humanize column_name, from
        to = log_fields_humanize column_name, to
      else
        from = nil
        to = log_fields_humanize column_name, content
      end
      [column_name.humanize, from, to]
    end
  end

  def log_fields_humanize column_name, content
    case column_name
      when "status"   then Task.statuses.keys[content].humanize
      when "priority" then Task.priorities.keys[content].humanize
      when "user_id"  then User.find_by(id: content).name
      else content
    end
  end
end
