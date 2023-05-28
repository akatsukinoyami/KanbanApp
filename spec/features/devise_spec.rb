describe "Sign in process", type: :feature do
  link = '/users/sign_in'

  before :all do
    @password = Faker::Internet.password
    @user = create(:user, password: @password)
  end
  
  it "not signs in user with incorrect credentials" do
    visit link
    within("#new_user") do
      fill_in :user_email, with: Faker::Internet.email
      fill_in :user_password, with: Faker::Internet.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
  end

  it "signs in user in direct flow" do
    visit link
    within("#new_user") do
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @password
    end
    
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end

describe "Sign out process", type: :feature do
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

  it "should lead to sign in page after sign out" do
    visit '/'

    click_button "Logout"
    expect(page).to have_content "Log in"
  end
end

describe "Sign up process", type: :feature do
  link = '/users/sign_up'
  before :each do
    password = Faker::Internet.password
    @values = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "#{@first_name}.#{@last_name}@#{Faker::Internet.domain_name}".downcase,
      password: password,
      password_confirmation: password,
    }
  end

  %i[first_name email password password_confirmation].each do |field|
    it "not signs up user without #{field}" do
      visit link
      within("#new_user") do
        @values.each do |key, value|
          next if key == field
          fill_in :"user_#{key}", with: value
        end
      end
      click_button 'Sign up'

      alert = if field == :password_confirmation
        "Password confirmation doesn't match Password" 
      else
        "#{field.to_s.humanize} can't be blank"
      end

      expect(page).to have_content alert
    end
  end

  it "signs up user in direct flow" do
    visit link
    within("#new_user") do
      @values.each do |key, value|
        fill_in :"user_#{key}", with: value
      end
    end
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end
end

describe "Devise redirects", type: :feature do
  [
    ['/users/sign_up', 'Log in'], 
    ['/users/sign_in', 'Sign up']
  ].each do |(link, button)|
    it "redirect to #{button} by a button" do
      visit link
      
      click_link button
      expect(page).to have_content button
    end
  end
end
