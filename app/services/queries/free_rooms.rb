# frozen_string_literal: true

module Queries
  class FreeRooms
    attr_accessor :from, :to

    QUERY = <<-SQL
      SELECT 
        per_day.per_day::date, r.hotel_id, sum(r.number_of_rooms) 
      FROM 
        generate_series(:from::date, :to::date, '1 day'::interval) as per_day 
      LEFT JOIN (
        SELECT 
          r.number_of_rooms, r.hotel_id, r.arrival_date, r.departure_date from reservations as r
        WHERE
          r.arrival_date < :to AND r.departure_date > :from
      ) r 
      ON 
        r.arrival_date <= per_day.per_day AND r.departure_date > per_day.per_day 
      GROUP BY 
        per_day.per_day, r.hotel_id;
    SQL

    def initialize(from:, to:)
      self.from = from
      self.to = to
    end

    def all
      hotels.each_with_object({}) do |(id, hotel), result|
        result[hotel.first] = for_hotel id
      end
    end

    def for_hotel(id)
      hotels[id].first.number_of_rooms - data.inject(0) do |max, d|
        next max unless d['hotel_id'] == id

        max >= d['sum'] ? max : d['sum']
      end
    end

    private

    def data
      @data ||= begin
        sanitized_sql = ActiveRecord::Base.sanitize_sql_array [QUERY, from: from, to: to]
        ActiveRecord::Base.connection.execute(sanitized_sql).to_a
      end
    end

    def hotels
      @hotels ||= Hotel.all.group_by(&:id)
    end
  end
end
