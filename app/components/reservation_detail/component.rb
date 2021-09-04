# frozen_string_literal: true

module ReservationDetail
  class Component < ViewComponent::Base
    attr_accessor :reservation

    with_collection_parameter :reservation

    def initialize(reservation:)
      self.reservation = reservation
    end
  end
end
