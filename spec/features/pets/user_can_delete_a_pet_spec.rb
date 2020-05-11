require 'rails_helper'

RSpec.describe "view pet show page", type: feature do
  describe "when I go to a pet's show page" do
    it "can click link to delete the pet" do
      shelter1 = Shelter.create(name: "Find-a-Friend",
                                address: "123 North Street",
                                city: "Denver",
                                state: "CO",
                                zip: 80223 )

      pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Milo",
                        age: "2",
                        sex: "Male",
                        shelter_id: shelter1.id
                      )

      pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                        name: "Lucy",
                        age: "6",
                        sex: "Female",
                        shelter_id: shelter1.id
                      )
    visit "/pets/#{pet1.id}"

    click_link 'Delete Pet'

    expect(current_path).to eq('/pets')
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet2.age)
    expect(page).to have_content(pet2.sex)
    expect(page).to have_content(pet2.shelter.name)
    end
  end
end
