class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    self.pets.count
  end

  def app_count
  end

  def avg_rating
    self.reviews.average(:rating)
  end
end
