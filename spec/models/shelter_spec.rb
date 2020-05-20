require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'relationships' do
    it {should have_many(:reviews).dependent(:destroy) }
    it {should have_many(:pets).dependent(:destroy) }
  end

  describe 'methods' do
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
                  status: "Adoptable")

    pet2 = Pet.create(image: "https://ichef.bbci.co.uk/wwfeatures/live/976_549/images/live/p0/7z/n7/p07zn7p7.jpg",
                      name: "Otis",
                      age: "3",
                      sex: "Male",
                      shelter_id: shelter1.id,
                      description: "Small white dog",
                      status: "Adoptable")

    review1 = Review.create(title: "Excellent service",
                           rating: 5,
                           content: "Found a great pet for my family.",
                           image: "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                           shelter_id: shelter1.id )

    review2 = Review.create(title: "Excellent service",
                           rating: 4,
                           content: "Found a great pet for my family.",
                           image: "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                           shelter_id: shelter1.id )
    
    application = Application.create(name: "Will Rogers",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{pet1.id}", "#{pet2.id}"])

    application2 = Application.create(name: "Roger Will",
      address: "132 Maple Dr.", city: "Claremore", state: "OK", zip: 74014, phone: "918-233-9000",
      description: "great fenced yard", pet_ids: ["#{pet1.id}", "#{pet2.id}"])

    it '#pet_count' do
      expect(shelter1.pet_count).to eq(2)
    end

    it '#app_count' do
      expect(shelter1.app_count).to eq(2)
    end

     it '#avg_rating' do
      expect(shelter1.avg_rating).to eq(4.5)
    end
  end
end
