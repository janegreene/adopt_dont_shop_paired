require 'rails_helper'

RSpec.describe "delete a shelter page", type: feature do
  describe "when I go to a single shelter page"
    it "can click link to delete the shelter" do
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

      visit "/shelters/#{shelter1.id}"

      click_link 'Delete Shelter'

      expect(page).to have_content(shelter2.name)
      # expect(page).to not_have_content(shelter1.name)
    end
end
