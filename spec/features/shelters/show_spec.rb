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
    describe "when I go to a single shelter page"
      it "can click link to update the shelter" do
        shelter1 = Shelter.create(name: "Find-a-Friend",
                                  address: "123 North Street",
                                  city: "Denver",
                                  state: "CO",
                                  zip: 80223 )

        visit "/shelters/#{shelter1.id}"

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
end
