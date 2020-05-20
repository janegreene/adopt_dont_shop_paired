require 'rails_helper'

RSpec.describe "when I go to the shelter pets index page" , type: feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Find-a-Friend",
                                  address: "123 North Street",
                                  city: "Denver",
                                  state: "CO",
                                  zip: 80223 )

    @pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Milo",
                      age: "2",
                      sex: "Male",
                      description: "yolo",
                      shelter_id: @shelter1.id)

    @pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                      name: "Lucy",
                      age: "6",
                      sex: "Female",
                      description: "yolo",
                      shelter_id: @shelter1.id)
  end

  describe "create shelter pet" do
    it "can click link to make new adoptable pet" do

     visit "/shelters/#{@shelter1.id}/pets"

     click_link "Create Pet"

     expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")

     fill_in "Image", with: "https://canineweekly.com/wp-content/uploads/2017/10/big-fluffy-dog-breeds-1024x683.jpg"
     fill_in "Name", with: "Noodle"
     fill_in "Description", with: "Big beautiful orphan"
     fill_in "Approximate Age", with: "5"
     fill_in "Sex", with: "Female"

     click_button "Create Pet"

     pet = Pet.last
     expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
     expect(page).to have_content(pet.name)
     expect(page).to have_content(pet.age)
     expect(page).to have_content(pet.sex)
    end
  end
    it "can see all pets from that shelter with their information" do
      visit "/shelters/#{@shelter1.id}/pets"

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(@pet1.sex)

        expect(page).to have_content(@pet2.name)
        expect(page).to have_content(@pet2.age)
        expect(page).to have_content(@pet2.sex)
      end

    it "incomplete form receives flash message" do

     visit "/shelters/#{@shelter1.id}/pets"

     click_link "Create Pet"

     expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")

     fill_in "Image", with: "https://canineweekly.com/wp-content/uploads/2017/10/big-fluffy-dog-breeds-1024x683.jpg"
     fill_in "Name", with: ""
     fill_in "Description", with: "Big beautiful orphan"
     fill_in "Approximate Age", with: "5"
     fill_in "Sex", with: "Female"

     click_button "Create Pet"
     expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")
     expect(page).to have_content("Name can't be blank")
   end
end
