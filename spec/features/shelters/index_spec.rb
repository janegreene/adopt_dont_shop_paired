require 'rails_helper'

RSpec.describe "create new shelter page", type: feature do
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
  end
  describe "when I go to the index page"
    it "can click link to make new shelter" do

    visit '/shelters'

    click_link "New Shelter"

    fill_in "Name", with: "Doggone Crazy"
    fill_in "Address", with: "789 East Street"
    fill_in "City", with: "Cincinnati"
    fill_in "State", with: "OH"
    fill_in "Zip", with: 41073

    click_button "Create Shelter"
    expect(page).to have_link("Doggone Crazy")
  end

  it "can see all shelter names" do
    visit "/shelters"

    expect(page).to have_link(@shelter1.name)
    expect(page).to have_link(@shelter2.name)
  end

  it "can see one shelter with all its attributes" do

    visit "/shelters"

    click_link(@shelter1.name, match: :first)

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.address)
    expect(page).to have_content(@shelter1.city)
    expect(page).to have_content(@shelter1.state)
    expect(page).to have_content(@shelter1.zip)
  end

  it "can see message when field is missing create" do
    visit '/shelters'

    click_link "New Shelter"

    fill_in "Name", with: "Doggone Crazy"
    fill_in "Address", with: ""
    fill_in "City", with: "Cincinnati"
    fill_in "State", with: "OH"
    fill_in "Zip", with: 41073

    click_button "Create Shelter"
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_no_content("Name can't be blank")
  end

  it "can see message when field is missing update" do
    visit "/shelters/#{@shelter1.id}"

    click_link "Update Shelter"

    fill_in "Name", with: ""
    fill_in "Address", with: "789 East Street"
    fill_in "City", with: "Cincinnati"
    fill_in "State", with: "OH"
    fill_in "Zip", with: 41073

    click_button "Submit Update"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_no_content("State can't be blank")

  end
end

# User Story 29, Flash Messages for Shelter Create and Update
#
# As a visitor
# When I am updating or creating a new shelter
# If I try to submit the form with incomplete information
# I see a flash message indicating which field(s) I am missing
