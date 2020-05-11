require 'rails_helper'

RSpec.describe "user sees one pet" do
  it "can see one pet will all of its attributes" do
    shelter1 = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )

    pet1 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Milo",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    visit pets_path

    click_link(pet1.name, match: :first)
    expect(page).to have_content("Milo")
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)
  end
end
