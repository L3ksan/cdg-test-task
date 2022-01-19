class Delivery < ApplicationRecord
  include ActiveModel::Validations
  validates :first_name, :middle_name, :last_name, length: { maximum: 255},
                                                   presence: true
  validates :phone_number, presence: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }
  validates :email, length: { maximum: 150 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :weight, :length, :width, :height, :origin, :destination, presence: true
end
