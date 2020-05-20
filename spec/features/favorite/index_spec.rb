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

    after(:each) do
      Pet.destroy_all
      Shelter.destroy_all
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

      within ".favorites" do
        expect(page).to_not have_content(@pet3.name)
      end
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

      click_button("Remove Favorite", match: :first)
      expect(current_path).to eq("/favorites")

      within ".favorites" do
       expect(page).to_not have_content(@pet1.name)
      end
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
    within ".favorites" do
    expect(page).to have_content("You have no favorited pets.")
    expect(page).to_not have_link("Remove All Favorited Pets")
  end
end

  it "List of Pets that have applications on them" do
    application = Application.create(name: "Will Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014,
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

    visit "/favorites"

      within(".apps") do
        expect(page).to have_link("#{@pet1.name}")
      end
    end
  end
end
