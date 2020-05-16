class Application < ApplicationRecord
   validates_presence_of :name, :address, :city, :state, :zip, :phone, :description
  # belongs_to :shelter
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
