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
    
    @application = Application.create(name: "Will Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

      @application2 = Application.create(name: "Roger Will",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])
  end
  it "can see all attributes of application" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Will Rogers")
    expect(page).to have_content("132 Maple Dr.")
    expect(page).to have_content("Claremore")
    expect(page).to have_content("OK")
    expect(page).to have_content(74014)
    expect(page).to have_content("great fenced yard")
    expect(page).to have_content("918-233-9000")
    have_link 'Milo', href: "/pets/#{@pet1.id}"
    have_link 'Otis', href: "/pets/#{@pet2.id}"
  end

  it "can click a link to approve the application" do
    
  visit "/applications/#{@application.id}"
   
  within(".pets-#{@pet1.id}") do
    expect(page).to have_link("Approve Application")
    click_link "Approve Application"
  end
    
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{@application.name}.")
  end
end

