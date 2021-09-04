# frozen_string_literal: true

class Hotel < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, :city, :number_of_rooms, :price, presence: true
  validates :number_of_rooms, :price, numericality: { greater_than: 0 }

  def free_rooms_at(from:, to:)
    number_of_rooms - reservations.where('arrival_date < ? AND departure_date > ?', to, from).sum(:number_of_rooms)
  end
end
