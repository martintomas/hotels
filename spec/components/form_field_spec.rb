# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormField::Component, type: :component do
  include ActionView::Context
  include ActionView::Helpers::FormHelper

  let(:reservation) { build :reservation }

  context 'when there are no errors' do
    before do
      form_for(reservation) do |f|
        render_inline described_class.new( f, :text_field, key: :first_name)
      end
    end

    it 'shows text field' do
      expect(rendered_component).to have_css "input[type='text']", count: 1
    end

    it 'shows label field' do
      expect(rendered_component).to have_css 'label', count: 1
    end

    it 'skips errors part' do
      expect(rendered_component).to have_css 'p.error', count: 0
    end
  end

  context 'when there are no errors' do
    before do
      reservation.first_name = nil
      reservation.valid?

      form_for(reservation) do |f|
        render_inline described_class.new( f, :text_field, key: :first_name, required: true)
      end
    end

    it 'shows text field' do
      expect(rendered_component).to have_css "input[type='text']", count: 1
    end

    it 'shows label field' do
      expect(rendered_component).to have_css 'label.required', count: 1
    end

    it 'shows errors part' do
      expect(rendered_component).to have_css 'p.error', text: reservation.errors.full_messages_for(:first_name).first
    end
  end
end
