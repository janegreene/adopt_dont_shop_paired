class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    self.pets.count
  end

  def app_count
    pet_ids = pets.pluck(:id)
    PetApplication.where(pet_id: pet_ids).select(:application_id).distinct.count
  end

  def avg_rating
    self.reviews.average(:rating)
  end
end
