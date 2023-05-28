FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@#{Faker::Internet.domain_name}".downcase }
    password { Faker::Internet.password }
  end

  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentences }
    status { Task.statuses.keys.sample }
    priority { Task.priorities.keys.sample }
    user
  end
end