# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teams new', type: :feature do
  let(:organisation) { create :organisation }

  it 'allows successful creation of team' do
    # Arrange
    visit new_organisation_team_path(organisation)

    # Act
    fill_in 'Name', with: 'Engineering'
    click_on 'Create'

    # Assert
    expect(page).to have_content('Engineering')
    expect(page).to have_current_path(organisation_team_path(organisation, Team.last))
  end
end
