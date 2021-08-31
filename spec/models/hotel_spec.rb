# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hotel, type: :model do
  let!(:hotel) { create :hotel }

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:number_of_rooms).of_type(:integer) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:reservations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :number_of_rooms }
    it { is_expected.to validate_presence_of :price }
  end
end
