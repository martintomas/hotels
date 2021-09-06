# frozen_string_literal: true

class Hotel < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, :city, :number_of_rooms, :price, presence: true
  validates :number_of_rooms, :price, numericality: { greater_than: 0 }

  def free_rooms_at(from:, to:)
    Queries::FreeRooms.new(from: from, to: to).for_hotel id
  end
end
