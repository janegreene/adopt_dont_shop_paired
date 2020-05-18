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
    it '#pet_count' do
    expect(shelter1.pet_count).to eq(0)
  end
  end
end
