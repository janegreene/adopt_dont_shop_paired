require 'rails_helper'

RSpec.describe "When I visit a pet's show page" do
  describe "see a button or link to favorite that pet" do
    it "can favorite a pet" do
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

    visit "/pets/#{pet1.id}"
    

    within(".column-#{pet1.id}") do
      click_button "Favorite Pet"
    end
    expect(current_path).to eq("/pets/#{pet1.id}")
    expect(page).to have_content("You have favorited #{pet1.name}.")
    # within '.navbar' do
    #   expect(page).to have_content("Favorite Pets: 1")
    # end
    end
  end
  
  it "can add multiple favorite pets" do
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
  # save_and_open_page

  visit "/pets/#{pet3.id}"

  within(".column-#{pet3.id}") do
    click_button "Favorite Pet"
  end
  expect(current_path).to eq("/pets/#{pet3.id}")
  within '.navbar' do
    expect(page).to have_content("Favorite Pets: 3")
  end
  end

  it "can add multiple favorite pets" do
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

    visit "/pets/#{pet3.id}"

    within(".column-#{pet3.id}") do
      click_button "Favorite Pet"
    end
    expect(current_path).to eq("/pets/#{pet3.id}")

    within '.navbar' do
        expect(page).to have_content("Favorite Pets: 3")
      end
    end

     it "no longer has a favorite button after pet has been favorited" do
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
                          status: "Adoptable")
      
       visit "/pets/#{pet1.id}"

      click_button "Favorite Pet"

       visit "/pets/#{pet1.id}"

       expect(page).to_not have_button("Favorite Pet")
       expect(page).to have_button("Remove From Favorites")
     end
    
  end





#     User Story 12, Can't Favorite a Pet More Than Once

# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
 



