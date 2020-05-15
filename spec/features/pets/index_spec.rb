require 'rails_helper'

RSpec.describe "view pet index page", type: feature do
  describe "when I go to the pet index page" do
    it "can see all pets and their information" do
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
                        shelter_id: shelter1.id
                      )

      pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                        name: "Lucy",
                        age: "6",
                        sex: "Female",
                        shelter_id: shelter2.id
                      )

      pet3 = Pet.create(image: "https://d17fnq9dkz9hgj.cloudfront.net/uploads/2018/02/Bernese-Mountain-Dog_01.jpg",
                        name: "Toaster",
                        age: "3",
                        sex: "Male",
                        shelter_id: shelter2.id
                      )

    visit '/pets'

    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(shelter1.name)
    end
  end
end
