class User < ApplicationRecord
  has_many :tasks
  
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  devise :database_authenticatable, :registerable, :validatable

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
