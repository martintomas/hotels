# frozen_string_literal: true

require 'rails_helper'

describe 'Search Hotels', type: :system do
  let!(:hotel_1) { create :hotel, number_of_rooms: 2 }
  let!(:hotel_2) { create :hotel, number_of_rooms: hotel_1.number_of_rooms + 1 }

  before do
    visit root_path
  end

  it 'shows searching component' do
    expect(page).to have_css '.search-component', count: 1
  end

  it 'shows all hotels' do
    expect(page).to have_content(hotel_1.name)
    expect(page).to have_content(hotel_2.name)
  end

  context 'when searching by number of rooms' do
    before do
      fill_in 'hotels_search_former[arrival_date]', with: 1.day.from_now
      fill_in 'hotels_search_former[departure_date]', with: 2.days.from_now
      fill_in 'hotels_search_former[number_of_rooms]', with: hotel_2.number_of_rooms
      click_on I18n.t('components.search.find_button')
    end

    it 'shows only hotels which fulfill requirements' do
      expect(page).not_to have_content(hotel_1.name)
      expect(page).to have_content(hotel_2.name)
    end
  end

  context 'when there are no hotels found' do
    before do
      fill_in 'hotels_search_former[arrival_date]', with: 1.day.from_now
      fill_in 'hotels_search_former[departure_date]', with: 2.days.from_now
      fill_in 'hotels_search_former[number_of_rooms]', with: hotel_2.number_of_rooms + 1
      click_on I18n.t('components.search.find_button')
    end

    it 'informs user' do
      expect(page).to have_content(I18n.t('hotels.not_found'))
    end
  end
end
