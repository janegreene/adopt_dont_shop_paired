require 'rails_helper'

RSpec.describe "the Application new page" do
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
                          shelter_id: @shelter1.id,
                          description: "Small white dog",
                          status: "Adoptable")
      
      @pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                          name: "Otis",
                          age: "3",
                          sex: "Male",
                          shelter_id: @shelter1.id,
                          description: "Small white dog",
                          status: "Adoptable")
  end

  it "should display a new application form" do
    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet2.id}"
    click_button "Favorite Pet"

    visit "/favorites"
    click_link "Adopt Favorite Pets"

    expect(current_path).to eq("/applications/new")

    select("#{@pet1.name}")
    select("#{@pet2.name}")
    fill_in "Name", with: "Will Rogers"
    fill_in "Address", with: "412 NW Maple Dr"
    fill_in "City", with: "Claremore"
    fill_in "State", with: "OK"
    fill_in "Zip", with: 74014
    fill_in "Phone", with: "918-222-2321"
    fill_in "Description", with: "Very few alligators in my yard..."

    click_button "Submit Application"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You have submitted your application to adopt.") #needs rework
    
    within '.favorites' do
      expect(page).to_not have_content("#{@pet1.name}")
      expect(page).to_not have_content("#{@pet2.name}")
    end
  end
  
  it "incomplete application" do
    visit "/pets/#{@pet1.id}"
    click_button "Favorite Pet"

    visit "/pets/#{@pet2.id}"
    click_button "Favorite Pet"

    visit "/favorites"
    click_link "Adopt Favorite Pets"

    expect(current_path).to eq("/applications/new")
    select("#{@pet1.name}")
    select("#{@pet2.name}")
    fill_in "Name", with: "Will Rogers"
    fill_in "Address", with: ""
    fill_in "City", with: "Claremore"
    fill_in "State", with: "OK"
    fill_in "Zip", with: 74014
    fill_in "Phone", with: "918-222-2321"
    fill_in "Description", with: "Very few alligators in my yard..."

    click_button "Submit Application"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not submitted: Required information missing.")
  end
end
