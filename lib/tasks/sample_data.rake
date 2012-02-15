namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
    admin = User.create!(name: "Daniel Romero",
                        email: "infoslack@gmail.com",
                        password: "teste123",
                        password_confirmation: "teste123")
    admin.toggle!(:admin)
    50.times do |n|
      name = Faker::Name.name
      email = "demo-#{n+1}@domain.com"
      password = "demopass"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
end

def make_microposts
  users = User.all(limit: 10)
  50.times do
    content = Faker::Lorem.sentence(9)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[1..20]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

#  User.create!(name: "Demo User",
#                email: "demo@domain.com",
#                password: "teste123",
#                password_confirmation: "teste123")

