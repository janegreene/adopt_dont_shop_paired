require 'rails_helper'

RSpec.describe "the Application new page" do
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
      status: "Adoptable"
    )
    @pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
      name: "Otis",
      age: "3",
      sex: "Male",
      shelter_id: @shelter1.id,
      description: "Small white dog",
      status: "Adoptable"
    )
  end
  it "should display a new application form" do
    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet2.id}"
    click_button "Favorite Pet"

    visit "/favorites"
    click_link "Adopt Favorite Pets"
    expect(current_path).to eq("/applications/new")
    # save_and_open_page
    select("#{@pet1.name}")
    select("#{@pet2.name}")
    fill_in "Name", with: "Will Rogers"
    fill_in "Address", with: "412 NW Maple Dr"
    fill_in "City", with: "Claremore"
    fill_in "State", with: "OK"
    fill_in "Zip", with: 74014
    fill_in "Phone", with: "918-222-2321"
    fill_in "Description", with: "Very few alligators in my yard..."
    click_button "Submit Application"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You have submitted your application to adopt.") #needs rework
    within '.favorites' do
      expect(page).to_not have_content("#{@pet1.name}")
      expect(page).to_not have_content("#{@pet2.name}")
    end
  end
  it "incomplete application" do
    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet2.id}"
    click_button "Favorite Pet"

    visit "/favorites"
    click_link "Adopt Favorite Pets"
    expect(current_path).to eq("/applications/new")
    # save_and_open_page
    select("#{@pet1.name}")
    select("#{@pet2.name}")
    fill_in "Name", with: "Will Rogers"
    fill_in "Address", with: ""
    fill_in "City", with: "Claremore"
    fill_in "State", with: "OK"
    fill_in "Zip", with: 74014
    fill_in "Phone", with: "918-222-2321"
    fill_in "Description", with: "Very few alligators in my yard..."
    click_button "Submit Application"
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not submitted: Required information missing.")
  end
end

# User Story 17, Incomplete application for a Pet
#
# As a visitor
# When I apply for a pet and fail to fill out any of the following:
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I'm redirect back to the new application form to complete the necessary fields
# And I see a flash message indicating that I must complete the form in order to submit the application
# User Story 16, Applying for a Pet
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
