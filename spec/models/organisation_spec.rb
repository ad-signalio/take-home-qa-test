# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  describe 'relationships' do
    subject { build :organisation }

    it { is_expected.to have_many(:teams) }
  end
end
