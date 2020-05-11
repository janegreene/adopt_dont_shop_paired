require 'rails_helper'

RSpec.describe "shelter index page", type: feature do
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
end
