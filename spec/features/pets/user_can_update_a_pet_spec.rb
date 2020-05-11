require 'rails_helper'

RSpec.describe "update a pet", type: feature do
  describe "when I go to a single pet page"
    it "can click link to update pet" do
      shelter1 = Shelter.create(name: "Find-a-Friend",
                                address: "123 North Street",
                                city: "Denver",
                                state: "CO",
                                zip: 80223 )

      pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Milo",
                        age: "2",
                        sex: "Male",
                        shelter_id: shelter1.id,
                        description: "Small white dog",
                        status: "Adoptable"
                      )
    visit "/pets/#{pet1.id}"

    click_link "Update Pet"

    expect(current_path).to eq("/pets/#{pet1.id}/edit")

    fill_in "Image", with: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg"
    fill_in "Name", with: "Milo"
    fill_in "Description", with: "Adorable, fluffy, small white dog"
    fill_in "Approximate Age", with: "3"
    fill_in "Sex", with: "Male"

    click_button "Submit Update"

    visit "/pets/#{pet1.id}"

    expect(current_path).to eq("/pets/#{pet1.id}")
    expect(page).to have_content("Adorable, fluffy, small white dog")
    expect(page).to have_content("3")
    end
end
