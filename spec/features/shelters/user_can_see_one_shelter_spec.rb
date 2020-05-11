require 'rails_helper'

RSpec.describe "user sees one shelter" do
  it "can see one shelter with all its attributes" do
    shelter = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )

    visit shelters_path

    click_link(shelter.name, match: :first)


    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.address)
    expect(page).to have_content(shelter.city)
    expect(page).to have_content(shelter.state)
    expect(page).to have_content(shelter.zip)
  end
end
