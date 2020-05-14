require 'rails_helper'

RSpec.describe Pet do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end
end
