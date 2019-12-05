#DOGS, USERS, ORDERS


puts "Currently Creating seed Users"
15.times do
  User.create(name: Faker::Name.name, age: Faker::Number.between(1, 100))
end
puts "Dog Walkin' Users now created!"

puts "Currently makin' some cute asf seed puppies."
100.times do
    #oldest living dog? Bluey, 29 years.
  Dog.create(name: Faker::Name.name, age: Faker::Number.between(from: 1, to: 29), owner_name: Faker::Name.name)
end
puts "Them Puppayyes ready to be walked boiiii!"

puts "CREATING FAKE WALKING ORDERS NOW"
10.times do
  Order.create(dog_id: Dog.all.sample.id, user_id: User.all.sample.id)
end
puts "SEED ORDERS, HAVE BEEN CREATED!"