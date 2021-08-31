# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let!(:reservation) { create :reservation }

  describe 'columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:arrival_date).of_type(:date) }
    it { is_expected.to have_db_column(:departure_date).of_type(:date) }
    it { is_expected.to have_db_column(:number_of_rooms).of_type(:integer) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:hotel) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :phone }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :arrival_date }
    it { is_expected.to validate_presence_of :departure_date }
    it { is_expected.to validate_presence_of :number_of_rooms }
    it { is_expected.not_to allow_value('foo', '12').for(:phone) }
    it { is_expected.to allow_value('123456789').for(:phone) }
    it { is_expected.not_to allow_value('foo').for(:email) }
    it { is_expected.to allow_value('foo@bar.com').for(:email) }
  end
end
