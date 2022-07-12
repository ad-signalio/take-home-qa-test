# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    subject(:user) { build :user }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:password) }
    it { is_expected.to validate_length_of(:phone_number).is_at_most(15) }

    it 'will be valid if phone number has letters' do
      user.phone_number = '+44 7000 000000'
      expect(user.errors.keys).not_to include(:phone_number)
    end

    it 'will be invalid if phone number has letters' do
      user.phone_number = '+44 700000000a'

      aggregate_failures do
        expect(user).not_to be_valid
        expect(user.errors[:phone_number]).to eq(['is invalid'])
      end
    end
  end
end
