# frozen_string_literal: true

module Search
  class Component < ViewComponent::Base
    attr_accessor :search_former

    def initialize(search_former)
      self.search_former = search_former
    end
  end
end
