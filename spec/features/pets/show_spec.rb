require 'rails_helper'

RSpec.describe "view pet show page", type: feature do
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
                      shelter_id: @shelter1.id)

    @pet2 = Pet.create(image: "https://cdn.akc.org/content/hero/lab_owner_hero.jpg",
                      name: "Lucy",
                      age: "6",
                      sex: "Female",
                      shelter_id: @shelter1.id)

  end

  describe "when I go to a pet's show page" do
    it "can click link to delete the pet" do

    visit "/pets/#{@pet1.id}"

    click_link 'Delete Pet'

    expect(current_path).to eq('/pets')
    expect(page).to have_content(@pet2.name)
    expect(page).to have_content(@pet2.age)
    expect(page).to have_content(@pet2.sex)
    expect(page).to have_content(@pet2.shelter.name)
    end
  end
  
  it "can see one pet will all of its attributes" do

    visit "/pets/#{@pet1.id}"

    click_link(@pet1.name, match: :first)
    expect(page).to have_content("Milo")
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
  end

  it "can favorite a pet" do

    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("You have favorited #{@pet1.name}.")
  end
  
  it "can click link to update pet" do

    visit "/pets/#{@pet1.id}"

    click_link "Update Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")

    fill_in "Image", with: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg"
    fill_in "Name", with: "Milo"
    fill_in "Description", with: "Adorable, fluffy, small white dog"
    fill_in "Approximate Age", with: "3"
    fill_in "Sex", with: "Male"

    click_button "Submit Update"

    visit "/pets/#{@pet1.id}"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adorable, fluffy, small white dog")
    expect(page).to have_content("3")
  end
end
