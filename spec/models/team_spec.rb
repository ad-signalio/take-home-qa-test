# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'relationships' do
    subject { build :team }

    it { is_expected.to belong_to(:organisation) }
  end
end
