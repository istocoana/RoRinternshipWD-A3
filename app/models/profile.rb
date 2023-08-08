class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true

  # validates :validate_street_address_with_google

  # private

  # def validate_street_address_with_google
  #   return unless street_address.present?
  #     response = Geocoder.search(street_address).first
  #     unless response && response.data['types'].include?('street_address')
  #       errors.add(:street_address, "Invalid or non-existent street address")
  #     end
  # end

end
