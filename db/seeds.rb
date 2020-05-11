# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


shelter1 = Shelter.create(name: "Find-a-Friend",
                          address: "123 North Street",
                          city: "Denver",
                          state: "CO",
                          zip: 80223 )

shelter2 = Shelter.create(name: "Pet Roulette" ,
                          address: "456 South Street",
                          city: "Englewood",
                          state: "CO",
                          zip: 80110 )

pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                  name: "Milo",
                  age: "2",
                  sex: "Male",
                  shelter_id: shelter1.id,
                  description: "Small white dog",
                  status: "Adoptable"
                )

pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                  name: "Lucy",
                  age: "6",
                  sex: "Female",
                  shelter_id: shelter2.id,
                  description: "This is a dog",
                  status: "Pending"
                )

pet3 = Pet.create(image: "https://d17fnq9dkz9hgj.cloudfront.net/uploads/2018/02/Bernese-Mountain-Dog_01.jpg",
                  name: "Toaster",
                  age: "3",
                  sex: "Male",
                  shelter_id: shelter2.id,
                  description: "Fluffly, snuggly dog",
                  status: "Adoptable"
                                )
