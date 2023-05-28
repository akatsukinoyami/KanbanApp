require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { build(:task) }

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    %i[title status priority user].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should define_enum_for(:status).with_values(Task.statuses.keys) }
    it { should define_enum_for(:priority).with_values(Task.priorities.keys) }
  end
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid without description" do
    task2 = build(:task, description: nil)
    expect(task2).to be_valid
  end
end
