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

  def pet_applicant
    id = self.applications.select(:id).where('pet_applications.approved')
    id.pluck(:id).first
  end

end
