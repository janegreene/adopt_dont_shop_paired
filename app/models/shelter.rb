class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets, dependent: :delete_all
  has_many :reviews, dependent: :delete_all
end
