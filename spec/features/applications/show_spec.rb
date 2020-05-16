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
      status: "Adoptable"
    )
    @pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
      name: "Otis",
      age: "3",
      sex: "Male",
      shelter_id: @shelter1.id,
      description: "Small white dog",
      status: "Adoptable"
    )
    @application = Application.create(name: "Will Rogers",
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
end
# User Story 19, Application Show Page
#
# As a visitor
# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pet's that this application is for (all names of pets should be links to their show page)
