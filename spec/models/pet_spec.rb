require 'rails_helper'

RSpec.describe Pet do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end
end
