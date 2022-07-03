# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |x|
  User.create!(
    email: "user#{x}@example.com", 
    password: "123456",
    password_confirmation: "123456", 
    role: ["admin", "superadmin"].sample,
    phone_number:"06#{x}12#{x}3#{x}5#{x}"
  )
end

25.times do |x|
  Article.create!(
    title: "Title #{x}",
    user_id: rand(User.first.id..User.last.id),
    text: "Text #{x} Words go here Idk",
    language: ["ukr", "eng"].sample,
    status: ["draft", "published", "trashed"].sample
    
  )
end