# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Component, type: :component do
  let(:search_former) { Hotels::SearchFormer.new number_of_rooms: 4 }

  before { render_inline described_class.new search_former }

  it 'contains all searching fields' do
    expect(rendered_component).to have_css "input[type='date'][name='hotels_search_former[arrival_date]']", count: 1
    expect(rendered_component).to have_css "input[type='date'][name='hotels_search_former[departure_date]']", count: 1
    expect(rendered_component).to have_css "input[type='number'][name='hotels_search_former[number_of_rooms]'][value=4]", count: 1
    expect(rendered_component).to have_css "input[type='number'][name='hotels_search_former[max_price_per_room]']", count: 1
  end

  it 'contains submit button' do
    expect(rendered_component).to have_css "input[type='submit'][value='#{I18n.t('components.search.find_button')}']", count: 1
  end
end
