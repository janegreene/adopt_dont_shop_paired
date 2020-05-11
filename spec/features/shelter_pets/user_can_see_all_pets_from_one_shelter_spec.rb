require 'rails_helper'

RSpec.describe "view shelter pets index page" do
  describe "when I go to the shelter pets index page" do
    it "can see all pets from that shelter with their information" do
      shelter1 = Shelter.create(name: "Find-a-Friend",
                                address: "123 North Street",
                                city: "Denver",
                                state: "CO",
                                zip: 80223 )

      pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                        name: "Milo",
                        age: "2",
                        sex: "Male",
                        shelter_id: shelter1.id)

      pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                        name: "Lucy",
                        age: "6",
                        sex: "Female",
                        shelter_id: shelter1.id)


      visit "/shelters/#{shelter1.id}/pets"

      # expect(page).to have_css("img[scr*= '#{pet1.image}']")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)

      # expect(page).to have_css("img[scr*= '#{pet2.image}']")
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet2.age)
      expect(page).to have_content(pet2.sex)
    end
  end
end
