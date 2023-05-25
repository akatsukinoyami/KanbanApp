class Task < ApplicationRecord
    scope :with_status, ->(status) { status ? where(status:) : self.all }
    scope :with_priority, ->(priority) { status ? where(priority:) : self.all }

    enum status: { to_do: 0, in_progress: 1, review: 2, done: 3, cancelled: 4 }
    enum priority: { high: 0, normal: 1, low: 2 }
    
    belongs_to :user

    audited
end
