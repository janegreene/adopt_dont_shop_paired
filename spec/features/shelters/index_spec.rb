require 'rails_helper'

RSpec.describe "create new shelter page", type: feature do
  describe "when I go to the index page"
    it "can click link to make new shelter" do
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
    visit "/shelters"

    expect(page).to have_link(shelter1.name)
    expect(page).to have_link(shelter2.name)
  end

  it "can see one shelter with all its attributes" do
    shelter = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )

    visit "/shelters"

    click_link(shelter.name, match: :first)


    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.address)
    expect(page).to have_content(shelter.city)
    expect(page).to have_content(shelter.state)
    expect(page).to have_content(shelter.zip)
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
  expect(page).to have_content("Sheleter not created. Required information missing: Address")#need to make dynamic
end
end

# User Story 29, Flash Messages for Shelter Create and Update
#
# As a visitor
# When I am updating or creating a new shelter
# If I try to submit the form with incomplete information
# I see a flash message indicating which field(s) I am missing
