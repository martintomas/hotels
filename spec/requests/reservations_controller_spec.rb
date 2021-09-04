# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :request do
  describe 'GET index' do
    it 'is successful' do
      get reservations_path

      expect(response).to be_successful
    end
  end

  describe 'GET new' do
    it 'is successful' do
      get new_reservation_path

      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    let!(:hotel) { create :hotel }

    context 'when reservation is valid' do
      it 'is successful' do
        post reservations_path, params: { reservation: { hotel_id: hotel.id,
                                                         first_name: 'First Name',
                                                         last_name: 'Last Name',
                                                         email: 'test@test.test',
                                                         phone: '123456789',
                                                         arrival_date: 1.day.from_now,
                                                         departure_date: 2.days.from_now,
                                                         number_of_rooms: 1 } }

        expect(response).to be_successful
        expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
      end
    end

    context 'when reservation is invalid' do
      it 'is successful' do
        post reservations_path, params: { reservation: { hotel_id: hotel.id } }

        expect(response).to be_successful
        expect(response.content_type).not_to eq('text/vnd.turbo-stream.html; charset=utf-8')
      end
    end
  end
end
