namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
  end
end

def make_users
  if false
    User.create!(first_name: "Wei-En",
               last_name: "Lee",
               email: "wlee.subscribe@gmail.com",
               password: "password",
               password_confirmation: "password",
               admin: true)
  end
  99.times do |n|
    name  = Faker::Name.name
    first_name = name.split[0]
    last_name = name.split[1]
    email = "example-#{n+1}@gmail.com"
    password  = "password"
    User.create!(first_name: first_name,
                 last_name: last_name,
                 email: email,
                 password: password,
                 password_confirmation: password)
    end
end

def make_posts               
  users = User.all(limit: 6)
    
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.posts.create!(content: content) unless user==User.first }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end


