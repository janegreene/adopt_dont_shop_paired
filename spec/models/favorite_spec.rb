require 'rails_helper'

RSpec.describe Favorite do

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
                      name: "Harry",
                      age: "2",
                      sex: "Male",
                      shelter_id: @shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable")
    
    @pet3 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Sally",
                      age: "2",
                      sex: "Male",
                      shelter_id: @shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable")
    
    @pet4 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Shelly",
                      age: "2",
                      sex: "Female",
                      shelter_id: @shelter1.id,
                      description: "Small brown dog",
                      status: "Adoptable")
    
    @favorite = Favorite.new({
      "#{@pet1.id}" => 1,
      "#{@pet2.id}" => 1 })
      @favorite.add_pet(@pet3.id)  
  end

  after(:each) do
    Pet.destroy_all
  end

  describe "methods" do
   
    it "#contents" do
      expect(@favorite.contents).to eq({"#{@pet1.id}" => 1, "#{@pet2.id}" => 1, "#{@pet3.id}" => 1})
    end

    it "#total_count" do
      expect(@favorite.total_count).to eq(3)
    end
    
    it "#add_pet" do
      @favorite.add_pet(@pet4)
      expect(@favorite.total_count).to eq(4)
    end

    it "#favorite_pets" do
      expect(@favorite.favorite_pets).to eq([@pet1, @pet2, @pet3])
    end

    it "#delete" do
      @favorite.delete(@pet3.id)
    expect(@favorite.contents).to eq({"#{@pet1.id}" => 1, "#{@pet2.id}" => 1})
    end
  end
end
