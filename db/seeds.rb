# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting tables..."

connection = ActiveRecord::Base.connection()
connection.execute("delete from action_text_rich_texts");
connection.execute("delete from active_storage_attachments");
connection.execute("delete from active_storage_blobs");
connection.execute("delete from friendly_id_slugs");

connection.close()

puts "Deleted auto genenerated tables..."


Tagging.delete_all 
Post.delete_all
Tag.delete_all 
Category.delete_all
User.delete_all

puts "Creating categories..."

Category.create(name: "Programming")
Category.create(name: "Web Development")
Category.create(name: "Ruby on Rails")
Category.create(name: "React")

puts "Creating tags..."
javascript = Tag.create(name: "javascript")
react = Tag.create(name: "react")
ruby = Tag.create(name: "ruby")
node = Tag.create(name: "node")

puts "Creating users..."
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

puts "Creating posts..."

index = 1
Category.all.each do |category|
  10.times do |i|
    puts "Post #{index}..."
    post = Post.new(title: "Post #{i}", 
      slug: "post-#{index}",
      tags: i % 2 == 0 ? [javascript, react] : [ruby, node],
      description: "Post details", category: category)

      post.save
      index = index + 1
  end
end