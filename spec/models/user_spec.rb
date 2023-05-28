require "rails_helper"

RSpec.describe User, :type => :model do
  subject { build(:user) }

  describe 'Associations' do
    it { should have_many(:tasks) }
  end

  describe 'Validations' do
    %i[first_name email].each do |field|
      it { should validate_presence_of(field) }
    end
  end

  before(:all) do
    @user1 = create(:user)
  end
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "has a unique email" do
    user2 = build(:user, email: @user1.email)
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do 
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end
end