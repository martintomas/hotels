# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Header::Component, type: :component do
  before { render_inline described_class.new }

  it 'contains logo' do
    expect(rendered_component).to have_css '.logo span.first_letter', text: 'H'
    expect(rendered_component).to have_css '.logo span.rest', text: 'otels'
  end

  it 'contains check reservation link' do
    expect(rendered_component).to have_css '.links', text: I18n.t('components.header.check_reservations_link')
  end
end
