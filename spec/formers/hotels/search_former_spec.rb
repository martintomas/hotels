# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hotels::SearchFormer do
  let!(:hotel) { create :hotel, number_of_rooms: 10, price: 10 }

  subject do
    described_class.new arrival_date: 1.day.from_now, departure_date: 5.days.from_now, number_of_rooms: 3,
                        max_price_per_room: 20
  end

  describe '.initialize' do
    it 'contains expected values' do
      expect(subject.arrival_date).to be_within(1.second).of 1.day.from_now
      expect(subject.departure_date).to be_within(1.second).of 5.day.from_now
      expect(subject.number_of_rooms).to eq(3)
      expect(subject.max_price_per_room).to eq(20)
    end

    context 'when date times are empty strings' do
      subject do
        described_class.new arrival_date: '', departure_date: '', number_of_rooms: 3, max_price_per_room: 20
      end

      it 'date values are converted to nil' do
        expect(subject.arrival_date).to be_nil
        expect(subject.departure_date).to be_nil
      end
    end

    context 'when date times are strings dates' do
      subject do
        described_class.new arrival_date: '16-2-2020', departure_date: '18-2-2020', number_of_rooms: 3,
                            max_price_per_room: 20
      end

      it 'date values are properly parsed' do
        expect(subject.arrival_date).to eq(Date.parse('16-2-2020'))
        expect(subject.departure_date).to eq(Date.parse('18-2-2020'))
      end
    end
  end

  describe '#valid?' do
    context 'when dates are filled' do
      it { is_expected.to be_valid }
    end

    context 'when dates are missing' do
      subject do
        described_class.new arrival_date: nil, departure_date: nil, number_of_rooms: 3, max_price_per_room: 20
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe '#entities' do
    context 'when not valid' do
      subject do
        described_class.new arrival_date: nil, departure_date: nil, number_of_rooms: 3, max_price_per_room: 20
      end

      it 'returns all hotels' do
        expect(subject.entities).to eq(Hotel.all.order(:price))
      end
    end

    context 'when no reservation exists' do
      it 'returns available hotel' do
        expect(subject.entities).to include(hotel)
      end
    end

    context 'when reservation exists on different date' do
      before do
        create :reservation, hotel: hotel, arrival_date: 1.year.from_now, departure_date: 2.years.from_now,
                             number_of_rooms: hotel.number_of_rooms
      end

      it 'returns available hotel' do
        expect(subject.entities).to include(hotel)
      end
    end

    context 'when reservation exists on same date but, there is still room in hotel' do
      before do
        create :reservation, hotel: hotel, arrival_date: subject.arrival_date, departure_date: subject.departure_date,
                             number_of_rooms: 1
      end

      it 'returns available hotel' do
        expect(subject.entities).to include(hotel)
      end
    end

    context 'when reservation exists on same date but, and there is not room at hotel' do
      before do
        create :reservation, hotel: hotel, arrival_date: subject.arrival_date, departure_date: subject.departure_date,
                             number_of_rooms: hotel.number_of_rooms
      end

      it 'returns empty response' do
        expect(subject.entities).not_to include(hotel)
      end
    end

    context 'when max price per room is below hotel price' do
      let(:hotel) { create :hotel, number_of_rooms: 10, price: subject.max_price_per_room + 1 }

      it 'returns empty response' do
        expect(subject.entities).not_to include(hotel)
      end
    end
  end

  describe '#forwarded_data' do
    it 'passes all searching data as hash' do
      expect(subject.forwarded_data).to eq({ arrival_date: subject.arrival_date,
                                             departure_date: subject.departure_date,
                                             number_of_rooms: subject.number_of_rooms })
    end
  end
end
