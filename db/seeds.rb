# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(
    first_name: "first_name", 
    last_name: "last_name", 
    email: "test@mail.com", 
    password: "q1w2e3r4"
)

%i[to_do in_progress review done cancelled].each do |status|
    %i[high normal low].each do |priority|
        Task.create!(
            title: "Task #{status} #{priority}",
            description: "",
            status:,
            priority:,
            user:
        )
    end
end