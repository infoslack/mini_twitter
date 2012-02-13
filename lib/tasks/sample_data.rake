namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke

    admin = User.create!(name: "Daniel Romero",
                        email: "infoslack@gmail.com",
                        password: "teste123",
                        password_confirmation: "teste123")
    admin.toggle!(:admin)

    User.create!(name: "Demo User",
                email: "demo@domain.com",
                password: "teste123",
                password_confirmation: "teste123")
    50.times do |n|
      name = Faker::Name.name
      email = "demo-#{n+1}@domain.com"
      password = "demopass"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end

    users = User.all(limit: 10)
    50.times do
      content = Faker::Lorem.sentence(9)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end
