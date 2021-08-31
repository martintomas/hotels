# frozen_string_literal: true

module HotelDetail
  class Component < ViewComponent::Base
    attr_accessor :hotel, :search_params

    def initialize(hotel, search_params)
      self.hotel = hotel
      self.search_params = search_params
    end
  end
end
