class User
  has_many :tasks
  
  validates :first_name, presence: true
  validates :email, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i },  uniqueness: { case_sensitive: false }

  devise :database_authenticatable, :registerable, :validatable
end
