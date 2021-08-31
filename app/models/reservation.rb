# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :hotel

  phony_normalize :phone, default_country_code: 'CZ'
  phony_normalized_method :phone

  validates :first_name, :last_name, :phone, :email, :arrival_date, :departure_date, :number_of_rooms, presence: true
  validates :number_of_rooms, numericality: { greater_than_or_equal_to: 0 }
  validates :departure_date, date: { after: :arrival_date }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, phony_plausible: true
end
