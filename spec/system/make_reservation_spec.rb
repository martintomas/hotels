# frozen_string_literal: true

require 'rails_helper'

describe 'Make Reservation', type: :system do
  let!(:hotel) { create :hotel }

  before do
    visit root_path
    click_on I18n.t('components.hotel_detail.make_reservation')
    fill_in 'reservation[first_name]', with: 'First Name'
    fill_in 'reservation[last_name]', with: 'Last Name'
    fill_in 'reservation[email]', with: 'test@test.test'
    fill_in 'reservation[phone]', with: '123456789'
    fill_in 'reservation[arrival_date]', with: 1.day.from_now
    fill_in 'reservation[departure_date]', with: 2.days.from_now
    fill_in 'reservation[number_of_rooms]', with: 1
    click_on I18n.t('reservations.submit_button')
  end

  it 'shows success message' do
    expect(page).to have_content(I18n.t('reservations.success.title'))
    expect(page).to have_content(I18n.t('reservations.success.subtitle', hotel_name: hotel.name))
  end

  context 'when visiting existing reservations' do
    before do
      visit reservations_path
    end

    it 'shows reservation there' do
      expect(page).to have_content(I18n.t('components.reservation_detail.hotel', name: hotel.name))
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('test@test.test')
      expect(page).to have_content('+420123456789')
    end
  end
end
