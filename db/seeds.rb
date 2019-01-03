require 'faker'

Post.destroy_all
Category.destroy_all

15.times do |index|
  Category.create!(name: Faker::Name.male_first_name)
end
categories = Category.all.map(&:name)

200.times do |index|
  Post.create!(title: Faker::Food.spice,
  	           created_at: Date.new(Date.today.year, rand(1..12), rand(1..28)),
               description: Faker::Lorem.paragraph(2, false, 10).chop,
               image: "site.com/here_is_a_picture_of_cardamom.jpg",
  			   category_id: Category.find_by(name: categories[rand(0..categories.size)]).id,
  			   published: true
  			  )
end