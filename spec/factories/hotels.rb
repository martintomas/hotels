# frozen_string_literal: true

FactoryBot.define do
  factory :hotel do
    name { Faker::Lorem.sentence }
    city { Faker::Address.city }
    number_of_rooms { Faker::Number.between(from: 20, to: 50) }
    price { Faker::Number.between(from: 1, to: 500) }
  end
end
