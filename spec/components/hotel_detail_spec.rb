# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HotelDetail::Component, type: :component do
  include ActionView::Helpers::NumberHelper

  let(:hotel) { create :hotel }
  let(:search_params) { { number_of_rooms: 1 } }

  before { render_inline described_class.new(hotel, search_params) }

  it 'contains image' do
    expect(rendered_component).to have_css '.image', count: 1
  end

  it 'have all content' do
    expect(rendered_component).to have_css '.name', text: hotel.name
    expect(rendered_component).to have_css '.city', text: hotel.city
    expect(rendered_component).to have_css '.price', text: I18n.t('components.hotel_detail.price', price: number_to_currency(hotel.price))
  end

  it 'have link to make reservation' do
    expected_link = new_reservation_path search_params.merge(hotel_id: hotel.id)
    expect(rendered_component).to have_css ".link a[href='#{expected_link}']", text: I18n.t('components.hotel_detail.make_reservation')
  end
end
