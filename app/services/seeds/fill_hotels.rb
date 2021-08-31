# frozen_string_literal: true

class Seeds::FillHotels
  def self.perform_for(hotels)
    hotels.each do |hotel|
      next if Hotel.where(name: hotel[:name]).exists?

      puts "hotel: #{hotel[:name]}"
      Hotel.create! hotel
    end
  end
end
