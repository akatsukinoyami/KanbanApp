class Task < ApplicationRecord
    belongs_to :user

    enum status: { to_do: 0, in_progress: 1, review: 2, done: 3, cancelled: 4 }
    enum priority: { high: 0, normal: 1, low: 1 }
end
