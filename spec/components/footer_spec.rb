# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Footer::Component, type: :component do
  before { render_inline described_class.new }

  it 'contains title' do
    expect(rendered_component).to have_text(I18n.t('components.footer.title'))
  end
end
