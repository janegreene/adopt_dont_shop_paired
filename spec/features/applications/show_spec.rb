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
    click_button "Approve Application for Milo"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for: #{@application2.name}")
  end
  it "can click a link to approve the application v2" do

    visit "/applications/#{@application.id}"

    expect(page).to have_button("Approve Application")
    click_button "Approve Application for #{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for: #{@application.name}")
  end

  it "Pets can only have one approved application on them at a time" do
    application2 = Application.create(name: "Bill Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}", "#{@pet2.id}"])

    visit "/applications/#{@application.id}"

    click_button "Approve Application for Milo"

    visit "/applications/#{application2.id}"
    expect(page).not_to have_content("Approve Application for Milo")
  end
  it "approved applications can be revoked" do
    application2 = Application.create(name: "Bill Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{@pet1.id}"])

    visit "/applications/#{application2.id}"

    click_button "Approve Application for #{@pet1.name}"
    visit "/applications/#{application2.id}"
    click_button "Unapprove Application for #{@pet1.name}"

    expect(current_path).to eq"/applications/#{application2.id}"

    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Adoptable")
  end
  it "anywhere an applicant name appears it is a link to show page" do

  visit "pets/#{@pet1.id}/applications"
  click_link(@application.name, match: :first)
  expect(current_path).to eq("/applications/#{@application.id}")

  end
end
