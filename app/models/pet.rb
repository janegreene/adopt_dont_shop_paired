class Pet < ApplicationRecord
  validates_presence_of :name, :image, :sex, :age, :description
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def on_hold_for
   name = self.applications.select(:name).where('pet_applications.approved')
   if !name.empty?
     name.pluck(:name).first
   end
  end
  # def adopter_name
  #   if self.pet_applications.any? { |app| app.approved == true }
  #     self.applications.pluck(:name).where(approved: :true)
  #
  #   require "pry"; binding.pry
  # end

end
