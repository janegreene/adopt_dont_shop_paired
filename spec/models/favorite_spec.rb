require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total favorites" do
      favorite = Favorite.new({
        1 => 1,
        2 => 1,
        3 => 1
   })
      expect(favorite.total_count).to eq(3)
    end
  end

  describe "#add_pet" do
  it "adds a pet to its contents" do
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
    pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Harry",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Sally",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    favorite = Favorite.new({
      "#{pet1.id}" => 1,
      "#{pet2.id}" => 1
    })
    favorite.add_pet(pet3.id)

    expect(favorite.contents).to eq({"#{pet1.id}" => 1, "#{pet2.id}" => 1, "#{pet3.id}" => 1})
  end
end
  describe "#total_count" do
  it "returns a count of all contents" do
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
    pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Harry",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Sally",
                      age: "2",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable"
                    )
    
    
    favorite = Favorite.new({
      "#{pet1.id}" => 1,
      "#{pet2.id}" => 1,
      "#{pet3.id}" => 1
    })

    expect(favorite.total_count).to eq(3)
  end
end
end
