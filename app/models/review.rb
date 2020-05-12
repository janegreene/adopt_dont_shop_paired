class Review < ApplicationRecord
  validates_presence_of :title
  belongs_to :shelter
end
