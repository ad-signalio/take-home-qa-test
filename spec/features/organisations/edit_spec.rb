# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisations edit', type: :feature do
  let(:organisation) { create :organisation }

  it 'allows successful update of existing organisation' do
    # Arrange
    visit edit_organisation_path(organisation)

    # Act
    fill_in 'Name', with: 'Ad-Signal'
    click_on 'Update'

    # Assert
    expect(page).to have_current_path(organisation_path(organisation))
    expect(page).to have_content('Ad-Signal')
  end
end
