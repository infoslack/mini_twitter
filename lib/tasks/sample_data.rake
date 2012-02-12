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
    99.times do |n|
      name = Faker::Name.name
      email = "demo-#{n+1}@domain.com"
      password = "demopass"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
  end
end
