# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { '+420123456789' }
    email { Faker::Internet.email }
    arrival_date { Faker::Date.between(from: Date.today, to: 20.days.from_now ) }
    departure_date { Faker::Date.between(from: 1.month.from_now, to: 2.months.from_now ) }
    number_of_rooms { Faker::Number.between(from: 1, to: 3) }

    hotel
  end
end
