# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :hotel

  phony_normalize :phone, default_country_code: 'CZ'
  phony_normalized_method :phone

  validates :first_name, :last_name, :phone, :email, :arrival_date, :departure_date, :number_of_rooms, presence: true
  validates :number_of_rooms, numericality: { greater_than: 0 }
  validates :departure_date, date: { after: :arrival_date }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, phony_plausible: true
  validate :available_free_rooms

  private

  def available_free_rooms
    return if hotel_id.blank? || arrival_date.blank? || departure_date.blank?

    if hotel.free_rooms_at(from: arrival_date, to: departure_date) < number_of_rooms
      errors.add(:number_of_rooms, :not_enough)
    end
  end
end
