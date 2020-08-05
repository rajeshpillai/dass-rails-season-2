# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.delete_all
Category.delete_all
User.delete_all
Tagging.delete_all 
Tag.delete_all 


Category.create(name: "Programming")
Category.create(name: "Web Development")
Category.create(name: "Ruby on Rails")
Category.create(name: "React")

javascript = Tag.create(name: "javascript")
react = Tag.create(name: "react")
ruby = Tag.create(name: "ruby")
node = Tag.create(name: "node")

admin_user = User.create(
  email: "rajesh@algorisys.com",
  username:"admin", password:"123456",
  password_confirmation:"123456")

10.times do |i|
    User.create(
        email: "user#{i}@algorisys.com",
        username:"user#{i}", password:"123456",
        password_confirmation:"123456")
    
end

Category.all.each do |category|
  10.times do |i|
      Post.create(title: "Post #{i}", 
        tags: i % 2 == 0 ? [javascript, react] : [ruby, node],
        description: "Post details", category: category)
  end
end