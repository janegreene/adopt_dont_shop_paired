class Pet < ApplicationRecord
  validates_presence_of :name, :image, :sex, :age, :description
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  # def adopter_name
  #   if self.pet_applications.any? { |app| app.approved == true }
  #     self.applications.pluck(:name).where(approved: :true)
  #
  #   require "pry"; binding.pry
  # end

end
