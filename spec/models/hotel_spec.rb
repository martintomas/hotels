# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hotel, type: :model do
  let!(:hotel) { create :hotel }

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:number_of_rooms).of_type(:integer) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:reservations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :number_of_rooms }
    it { is_expected.to validate_presence_of :price }
  end

  describe '#free_rooms_at' do
    let!(:hotel) { create :hotel, number_of_rooms: 10 }
    let(:arrival_date) { 1.day.from_now }
    let(:departure_date) { 10.days.from_now }

    context 'when there is no reservation' do
      it 'returns number of hotel rooms' do
        expect(hotel.free_rooms_at(from: arrival_date, to: departure_date)).to eq(hotel.number_of_rooms)
      end
    end

    context 'when there is reservations at different dates' do
      before do
        create :reservation, hotel: hotel, arrival_date: departure_date + 1.day, departure_date: departure_date + 2.days,
                             number_of_rooms: 5
      end

      it 'returns number of hotel rooms' do
        expect(hotel.free_rooms_at(from: arrival_date, to: departure_date)).to eq(hotel.number_of_rooms)
      end
    end

    context 'when there is reservations at same dates' do
      let!(:reservation) do
        create :reservation, hotel: hotel, arrival_date: arrival_date + 1.day, departure_date: departure_date,
                             number_of_rooms: 5
      end

      it 'returns number of hotel rooms minus already reserved rooms' do
        expect(hotel.free_rooms_at(from: arrival_date, to: departure_date)).to eq(hotel.number_of_rooms - reservation.number_of_rooms)
      end
    end
  end
end
