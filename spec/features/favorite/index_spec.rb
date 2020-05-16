require 'rails_helper'

RSpec.describe "When I have add pets to my favorites list" do
  describe "And I go to the favorites show page" do
    before(:each) do
      @shelter1 = Shelter.create(name: "Find-a-Friend",
                            address: "123 North Street",
                            city: "Denver",
                            state: "CO",
                            zip: 80223 )

      @pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Milo",
                        age: "2",
                        sex: "Male",
                        shelter_id: @shelter1.id,
                        description: "Small white dog",
                        status: "Adoptable")

      @pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Harry",
                        age: "2",
                        sex: "Male",
                        shelter_id: @shelter1.id,
                        description: "Small white dog",
                        status: "Adoptable")

      @pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Sally",
                        age: "2",
                        sex: "Male",
                        shelter_id: @shelter1.id,
                        description: "Small white dog",
                        status: "Adoptable")
        end

      it "can see my favorited pets and their info" do

        visit "/pets/#{@pet1.id}"

        within(".column-#{@pet1.id}") do
            click_button "Favorite Pet"
        end

        visit "/pets/#{@pet2.id}"

        within(".column-#{@pet2.id}") do
            click_button "Favorite Pet"
        end

        visit "/favorites"

        expect(current_path).to eq("/favorites")
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)
        expect(page).to_not have_content(@pet3.name)
    end


      it "can click link to remove pet from favorite" do
        visit "/pets/#{@pet1.id}"

        within(".column-#{@pet1.id}") do
            click_button "Favorite Pet"
        end

        visit "/pets/#{@pet2.id}"

        within(".column-#{@pet2.id}") do
            click_button "Favorite Pet"
        end

        visit "/favorites"

        # click_button "Remove Favorite"
        click_button("Remove Favorite", match: :first)
        expect(current_path).to eq("/favorites")
        expect(page).to_not have_content(@pet1.name)
        # within(".pet_container-#{@pet1.id}") do
        #   click_button "Remove Favorite"
        # end
    end

    describe "when I have no favorite pets" do
      it "shows a message saying I have no favorites" do
        visit "/favorites"
        expect(page).to have_content("You have no favorited pets.")
      end
    end

    it "can click link to remove all pets from favorites" do
        visit "/pets/#{@pet1.id}"

        within(".column-#{@pet1.id}") do
            click_button "Favorite Pet"
        end

        visit "/pets/#{@pet2.id}"

        within(".column-#{@pet2.id}") do
            click_button "Favorite Pet"
        end

        visit "/favorites"

        expect(page).to have_link("Remove All Favorited Pets")

        click_link "Remove All Favorited Pets"

        expect(current_path).to eq("/favorites")
        expect(page).to have_content("You have no favorited pets.")
        expect(page).to_not have_link("Remove All Favorited Pets")
    end
  it "List of Pets that have applications on them" do

    application = Application.create(name: "Will Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014,
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

      visit "/favorites"
      within(".apps-#{@pet1.id}") do
        have_link "#{@pet1.name}", href: "/pets/#{@pet1.id}"
      end
  end
end
end
#
# User Story 18, List of Pets that have applications on them
#
# As a visitor
# After one or more applications have been created
# When I visit the favorites index page
# I see a section on the page that has a list of all of the pets that have at least one application on them
# Each pet's name is a link to their show page
#
# # User Story 15, Remove all Favorite from Favorites Page
#
# # As a visitor
# # When I have added pets to my favorites list
# # And I visit my favorites page ("/favorites")
# # I see a link to remove all favorited pets
# # When I click that link
# # I'm redirected back to the favorites page
# I see the text saying that I have no favorited pets
# And the favorites indicator returns to 0
