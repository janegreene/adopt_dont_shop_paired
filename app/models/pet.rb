class Pet < ApplicationRecord
  validates_presence_of :name
  belongs_to :shelter
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
