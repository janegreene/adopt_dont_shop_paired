require 'rails_helper'

RSpec.describe " Pet Applications Index from pet show page" do
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
  it "link to view all applications for this pet" do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_link("View all Applications")
    click_link "View all Applications"
    expect(current_path).to eq("/pets/#{@pet1.id}/applications")
    have_link "#{@application.name}", href: "/applications/#{@application.id}"
  end
  it "link to view all applications for this pet" do
    pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
      name: "Randy",
      age: "3",
      sex: "Male",
      shelter_id: @shelter1.id,
      description: "Bites",
      status: "Adoptable"
    )
    visit "/pets/#{pet3.id}/applications"

    expect(page).to have_content("No applications for this pet yet.")
  end
end
# User Story 21, Pet Applications Index Page When No Applications
#
# As a visitor
# When I visit a pet applications index page for a pet that has no applications on them
# I see a message saying that there are no applications for this pet yet
# User Story 20, Pet Applications Index Page
#
# As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page
