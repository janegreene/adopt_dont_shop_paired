class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
