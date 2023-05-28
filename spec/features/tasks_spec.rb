def random_status
  Task.statuses.keys.sample.humanize
end

def random_priority
  Task.priorities.keys.sample.humanize
end

def footer_text
  regexp = /Today\'s activity: (\d+) tickets updated/
  find("div.navbar-nav", text: regexp).text
end

describe "tasks", type: :feature do
  let(:title) { Faker::Lorem.sentence }

  before :each do
    password = Faker::Internet.password
    @user = create(:user, password: password)

    visit '/users/sign_in'
    within("#new_user") do
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: password
    end
    
    click_button 'Log in'
  end

  describe "index", type: :feature do
    it "should open dashboard after login" do
      visit '/'

      expect(page).to have_content "Tasks"
      expect(page).to have_content "Filter by priority"
      Task.statuses.keys.each do |status|
        expect(page).to have_content status.humanize
      end
    end

    %i[high normal low].each do |priority|
      it "should filter tasks by filter (#{priority})", js: true do
        task = create(:task, title: title, priority: priority, user: @user)
        visit '/'
        
        find("label[for=btn-check]").click #"Filter by priority" button
        filter = find("##{priority}_priority_filter")
        
        expect(page).to have_content title
        filter.click
        
        sleep 1
        expect(page).not_to have_content title
        filter.click
      end
    end

    it "should open create task page by '+' button" do
      visit '/'
      click_link "+"

      expect(page).to have_content "New task"
    end
  end

  describe "create", type: :feature do
    let(:description) { Faker::Lorem.sentences.join(". ") }
    let(:status_select) { select random_status, from: :task_status }
    let(:priority_select) { select random_priority, from: :task_priority }

    it "should create task in direct flow" do
      visit '/tasks/new'
      before_footer_text = footer_text
  
      fill_in :task_title, with: title
      fill_in :task_description, with: description
      status_select.select_option
      priority_select.select_option
      click_button "Create"
  
      expect(page).to have_content "Task was successfully created"
      expect(page).to have_content title
      expect(footer_text).not_to eq before_footer_text
    end
  end

  describe "edit", type: :feature do
    let(:title2) { Faker::Lorem.sentence }
    let(:task)   { create(:task, title: title, user: @user) }

    before :each do
      task
      visit '/'
  
      click_link "Edit"
      fill_in :task_title, with: title2
    end

    it "should edit task in direct flow" do
      before_footer_text = footer_text
      click_button "Update"
      
      expect(footer_text).not_to eq before_footer_text
      expect(page).not_to have_content title
      expect(page).to have_content title2
      expect(page).to have_content "Task was successfully updated"
    end

    it "should discard changes by back button" do
      before_footer_text = footer_text
      click_link "Back"
      
      expect(footer_text).to eq before_footer_text
      expect(page).to have_content title
      expect(page).not_to have_content title2
      expect(page).not_to have_content "Task was successfully updated"
    end
  end

  describe "destroy", type: :feature do
    let(:task) { create(:task, title: title, user: @user) }

    it "should destroy tsk in direct flow" do
      before = footer_text
      
      task
      visit '/'

      expect(page).to have_content title
      click_button "Delete"

      expect(footer_text).not_to eq before
      expect(page).not_to have_content title
      expect(page).to have_content "Task was successfully destroyed"
    end
  end
end

