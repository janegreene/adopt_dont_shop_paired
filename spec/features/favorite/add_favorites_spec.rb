require 'rails_helper'

RSpec.describe "When I visit a pet's show page" do
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

  describe "see a button or link to favorite that pet" do
    it "can favorite a pet" do

    visit "/pets/#{@pet1.id}"


    within(".column-#{@pet1.id}") do
      click_button "Favorite Pet"
    end

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("You have favorited #{@pet1.name}.")

    within '.navbar' do
      expect(page).to have_content("Favorite Pets: 1")
    end
  end
end

  it "can add multiple favorite pets" do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Favorite Pets: 0")

    within(".column-#{@pet1.id}") do
      click_button "Favorite Pet"
    end

    expect(page).to have_content("Favorite Pets: 1")

    visit "/pets/#{@pet2.id}"

    within(".column-#{@pet2.id}") do
      click_button "Favorite Pet"
    end

    visit "/pets/#{@pet3.id}"

    expect(page).to have_content("Favorite Pets: 2")

    within(".column-#{@pet3.id}") do
      click_button "Favorite Pet"
    end

    expect(current_path).to eq("/pets/#{@pet3.id}")

    within '.navbar' do
      expect(page).to have_content("Favorite Pets: 3")
    end
  end

  it "can add multiple favorite pets" do

    visit "/pets/#{@pet1.id}"

    within(".column-#{@pet1.id}") do
      click_button "Favorite Pet"
    end

    visit "/pets/#{@pet2.id}"

    within(".column-#{@pet2.id}") do
      click_button "Favorite Pet"
    end

    visit "/pets/#{@pet3.id}"

    within(".column-#{@pet3.id}") do
      click_button "Favorite Pet"
    end

    expect(current_path).to eq("/pets/#{@pet3.id}")

    within '.navbar' do
      expect(page).to have_content("Favorite Pets: 3")
    end
  end


  it "no longer has a favorite button after pet has been favorited" do

    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet1.id}"

    expect(page).to_not have_button("Favorite Pet")
    expect(page).to have_button("Remove From Favorites")
  end

  it "pet can be removed from favorites" do

    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet1.id}"
    click_button "Remove From Favorites"

    expect(page).to have_content("Favorite Pets: 0")

    visit "/pets/#{@pet1.id}"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to_not have_button("Remove From Favorites")
  end
end
