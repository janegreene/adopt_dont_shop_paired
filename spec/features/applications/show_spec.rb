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
      description: "great fenced yard", pet_ids: ["#{@pet1.id}"])

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
    visit "/applications/#{@application2.id}"
    select("#{@pet1.name}")
    # expect(page).to have_button("Approve Application")
    click_button "Approve Application"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{@application2.name}.")
  end
  it "can click a link to approve the application v2" do

    visit "/applications/#{@application.id}"
    select("#{@pet1.name}")
    select("#{@pet2.name}")

    expect(page).to have_button("Approve Application")
    click_button "Approve Application"
    expect(current_path).to eq("/pets")
    click_link "#{@pet1.name}"
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{@application.name}.")
  end

  it "Pets can only have one approved application on them at a time" do
    application2 = Application.create(name: "Bill Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

    visit "/applications/#{@application.id}"

    select("#{@pet1.name}")
    select("#{@pet2.name}")

    click_button "Approve Application"

    visit "/applications/#{application2.id}"
    select("#{@pet1.name}")
    click_button "Approve Application"
    expect(page).to have_content("No more applications can be approved for this pet at this time.")
  end
end

# User Story 24, Pets can only have one approved application on them at any time
#
# [ ] done
#
# As a visitor
# When a pet has more than one application made for them
# And one application has already been approved for them
# I can not approve any other applications for that pet but all other applications
# still remain on file (they can be seen on the pets application index page)
# (This can be done by either taking away the option to approve the application,
#   or having a flash message pop up saying that no more applications can be
#   approved for this pet at this time)
