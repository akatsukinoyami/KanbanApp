class Task < ApplicationRecord
    scope :with_status, ->(status) { where(status:) }
    scope :with_priority, ->(priority) { where(priority:) }

    enum status: { to_do: 0, in_progress: 1, review: 2, done: 3, cancelled: 4 }
    enum priority: { high: 0, normal: 1, low: 2 }
    
    belongs_to :user

    audited
end
