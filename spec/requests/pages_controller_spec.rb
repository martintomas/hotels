# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :request do
  describe 'GET home' do
    it 'is successful' do
      get home_pages_path

      expect(response).to be_successful
    end
  end
end
