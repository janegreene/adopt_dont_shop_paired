require 'rails_helper'

RSpec.describe "When I have add pets to my favorites list" do
    describe "And I go to the favorites show page" do
          it "can see my favorited pets and their info" do
    shelter1 = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )

    pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Milo",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Harry",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Sally",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )

        visit "/pets/#{pet1.id}"

        within(".column-#{pet1.id}") do
            click_button "Favorite Pet"
        end
        visit "/pets/#{pet2.id}"

        within(".column-#{pet2.id}") do
            click_button "Favorite Pet"
         end

         visit "/favorites"

         expect(current_path).to eq("/favorites")
         expect(page).to have_content(pet1.name)
         expect(page).to have_content(pet2.name)
         expect(page).to_not have_content(pet3.name)
    end
end
end


# User Story 10, Favorite Index Page

# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites index page ("/favorites")
# I see all pets I've favorited
# Each pet in my favorites shows the following information:
# - pet's name (link to pets show page)
# - pet's image