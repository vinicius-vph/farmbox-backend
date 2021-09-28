class FieldNote < ApplicationRecord
  validates :long_text, :user, :date, :latitude, :longitude, presence: true
end
