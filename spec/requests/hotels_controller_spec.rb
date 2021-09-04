# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HotelsController, type: :request do
  describe 'GET index' do
    it 'is successful' do
      get hotels_path

      expect(response).to be_successful
    end
  end

  describe 'TurboStream search' do
    context 'when searching form is valid' do
      it 'is successful' do
        post search_hotels_path, as: :turbo_stream, params: { hotels_search_former: { arrival_date: 1.day.from_now,
                                                                                      departure_date: 2.days.from_now,
                                                                                      number_of_rooms: 2,
                                                                                      max_price_per_room: 10.5 }}

        expect(response).to be_successful
        expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
      end
    end

    context 'when searching form is invalid' do
      it 'is successful' do
        post search_hotels_path, as: :turbo_stream

        expect(response).to be_successful
        expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
      end
    end
  end
end
