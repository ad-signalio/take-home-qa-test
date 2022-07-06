# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisations new', type: :feature do
  it 'allows successful creation of organisation' do
    # Arrange
    visit new_organisation_path

    # Act
    fill_in 'Name', with: 'Ad-Signal'
    click_on 'Create'

    # Assert
    expect(page).to have_content('Ad-Signal')
    expect(page).to have_current_path(organisation_path(Organisation.last))
  end
end
