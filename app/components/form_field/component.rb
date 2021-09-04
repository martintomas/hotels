# frozen_string_literal: true

module FormField
  class Component < ViewComponent::Base
    attr_accessor :f, :type, :key, :required, :kwargs

    def initialize(f, type, key:, required: false, **kwargs)
      self.f = f
      self.type = type
      self.key = key
      self.required = required
      self.kwargs = kwargs
    end

    def field_classes
      'required' if required
    end
  end
end
