# frozen_string_literal: true

class Hotel < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, :city, :number_of_rooms, :price, presence: true
  validates :number_of_rooms, :price, numericality: { greater_than_or_equal_to: 0 }
end
