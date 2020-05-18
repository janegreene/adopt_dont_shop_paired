require 'rails_helper'

RSpec.describe "From a shelter show page", type: feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )

    @shelter2 = Shelter.create(name: "Pet Roulette" ,
                              address: "456 South Street",
                              city: "Englewood",
                              state: "CO",
                              zip: 80110 )

    @pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Milo",
                      age: "2",
                      sex: "Male",
                      shelter_id: @shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable")

    @pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Otis",
                      age: "3",
                      sex: "Male",
                      shelter_id: @shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable")

    @review1 = Review.create(title: "Excellent service",
                           rating: 5,
                           content: "Found a great pet for my family.",
                           image: "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                           shelter_id: @shelter1.id )

    @review2 = Review.create(title: "Excellent service",
                           rating: 4,
                           content: "Found a great pet for my family.",
                           image: "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                           shelter_id: @shelter1.id )
    
    @application = Application.create(name: "Will Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

    @application2 = Application.create(name: "Roger Will",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])
  end

  it "can click link to delete the shelter" do
    visit "/shelters/#{@shelter2.id}"

    click_link 'Delete Shelter'

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_no_content(@shelter2.name)
  end

  it "can click link to update the shelter" do
    visit "/shelters/#{@shelter1.id}"
    
    click_link 'Update Shelter'

    fill_in "Name", with: "Find-a-Friend"
    fill_in "Address", with: "867 1st Street"
    fill_in "City", with: "Aurora"
    fill_in "State", with: "CO"
    fill_in "Zip", with: 80016

    click_button "Submit Update"

    expect(page).to have_content("Find-a-Friend")
    expect(page).to have_content("867 1st Street")
    expect(page).to have_content("Aurora")
    expect(page).to have_content("CO")
    expect(page).to have_content("80016")
  end

  it "can see shelters statistics" do
    visit "/shelters/#{@shelter1.id}"

    within ".statistics" do
      expect(page).to have_content("Number of Pets: 2")
      binding.pry
      expect(page).to have_content("Number of Applications: 2")
      expect(page).to have_content("Average Rating: 4.5")
    end
  end
end


# User Story 30, Shelter Statistics

# As a visitor
# When I visit a shelter's show page
# I see statistics for that shelter, including:
# - count of pets that are at that shelter
# - average shelter review rating
# - number of applications on file for that shelter