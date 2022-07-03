# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(
#   email: 'dean@example.com', 
#   encrypted_password: '', 
#   created_at: '2016-06-22 19:10:25-07',
#   updated_at: '2016-06-22 19:10:25-07'
# )

25.times do |x|
  Article.create!(
    title: "Title #{x}",
    user_id: 1,
    text: "Text #{x} Words go here Idk",
    language: "eng",
    status: "published"
    # user_id: rand(User.first.id ** User.last.id),
    
    # language: ["ukr", "eng"].sample
    
  )
end