require 'rails_helper'

RSpec.describe "create shelter pet", type: feature do
  describe "when I go to the shelter pet index page"
    it "can click link to make new adoptable pet" do
      shelter1 = Shelter.create(name: "Find-a-Friend",
                                address: "123 North Street",
                                city: "Denver",
                                state: "CO",
                                zip: 80223 )

     visit "/shelters/#{shelter1.id}/pets"

     click_link "Create Pet"

     expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")

     fill_in "Image", with: "https://canineweekly.com/wp-content/uploads/2017/10/big-fluffy-dog-breeds-1024x683.jpg"
     fill_in "Name", with: "Noodle"
     fill_in "Description", with: "Big beautiful orphan"
     fill_in "Approximate Age", with: "5"
     fill_in "Sex", with: "Female"


     click_button "Create Pet"

     pet = Pet.last
     expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
     expect(page).to have_content(pet.name)
     expect(page).to have_content(pet.age)
     expect(page).to have_content(pet.sex)
    end
end
