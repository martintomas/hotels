# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationDetail::Component, type: :component do
  let(:reservation) { create :reservation }

  before { render_inline described_class.new(reservation: reservation) }

  it 'has all reservation information' do
    expect(rendered_component).to have_css '.hotel', text: I18n.t('components.reservation_detail.hotel', name: reservation.hotel.name)
    expect(rendered_component).to have_css '.first_name', text: reservation.first_name
    expect(rendered_component).to have_css '.last_name', text: reservation.last_name
    expect(rendered_component).to have_css '.email', text: reservation.email
    expect(rendered_component).to have_css '.phone', text: reservation.phone
    expect(rendered_component).to have_css '.arrival_date', text: I18n.t('components.reservation_detail.arrival_date', date: reservation.arrival_date)
    expect(rendered_component).to have_css '.departure_date', text: I18n.t('components.reservation_detail.departure_date', date: reservation.departure_date)
    expect(rendered_component).to have_css '.number_of_rooms', text: I18n.t('components.reservation_detail.number_of_rooms', number: reservation.number_of_rooms)
    expect(rendered_component).to have_css '.created_at', text: I18n.t('components.reservation_detail.created_at', date: reservation.created_at)
  end
end
