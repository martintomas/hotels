# frozen_string_literal: true

module Hotels
  class SearchFormer
    include ActiveModel::Model

    attr_accessor :arrival_date, :departure_date, :number_of_rooms, :max_price_per_room

    validates :arrival_date, :departure_date, presence: true
    validates :departure_date, date: { after: :arrival_date }

    def initialize(attributes = {})
      super attributes
      self.number_of_rooms ||= 1
      self.arrival_date = valid_date_from arrival_date
      self.departure_date = valid_date_from departure_date
    end

    def entities
      return Hotel.all unless valid?

      available_hotels
    end

    def valid?
      super
      errors.blank?
    end

    def forwarded_data
      { arrival_date: arrival_date, departure_date: departure_date, number_of_rooms: number_of_rooms }
    end

    private

    def available_hotels
      hotels = Hotel.joins("LEFT JOIN (#{reservation_subquery}) AS r ON r.hotel_id = hotels.id")
                    .where('hotels.number_of_rooms - coalesce(r.occupancy, 0) >= ?', number_of_rooms)
      hotels = hotels.where('price <= ?', max_price_per_room) if max_price_per_room.present?
      hotels.order :price
    end

    def reservation_subquery
      Reservation.select('hotel_id, sum(number_of_rooms) as occupancy')
                 .where('arrival_date < ? AND departure_date > ?', departure_date, arrival_date)
                 .group(:hotel_id).to_sql
    end

    def valid_date_from(value)
      return if value.blank?
      return Date.parse(value) if value.is_a? String

      value
    end
  end
end
