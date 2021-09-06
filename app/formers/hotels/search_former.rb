# frozen_string_literal: true

module Hotels
  class SearchFormer
    include ActiveModel::Model

    attr_accessor :arrival_date, :departure_date, :number_of_rooms, :max_price_per_room

    validates :arrival_date, :departure_date, presence: true
    validates :arrival_date, date: { after_or_equal_to: ->(_) { Time.current },
                                     message: :not_future },
                             if: -> { arrival_date.present? }
    validates :departure_date, date: { after: :arrival_date }, if: -> { arrival_date.present? }

    def initialize(attributes = {})
      super attributes
      self.number_of_rooms ||= 1
      self.arrival_date = valid_date_from arrival_date
      self.departure_date = valid_date_from departure_date
    end

    def entities
      return Hotel.all.order(:price) unless valid?

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
      hotels = Queries::FreeRooms.new(from: arrival_date, to: departure_date).all
                                 .select { |_hotel, free_rooms| free_rooms >= number_of_rooms.to_i }
                                 .keys.sort_by(&:price)
      hotels = hotels.select { |hotel| hotel.price <= max_price_per_room.to_f } if max_price_per_room.present?
      hotels
    end

    def valid_date_from(value)
      return if value.blank?
      return Date.parse(value) if value.is_a? String

      value
    end
  end
end
