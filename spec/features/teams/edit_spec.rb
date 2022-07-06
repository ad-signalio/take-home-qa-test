# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teams edit', type: :feature do
  let(:organisation) { create :organisation }
  let(:team) { create :team, organisation: organisation }

  it 'allows successful update of existing team' do
    # Arrange
    visit edit_organisation_team_path(organisation, team)

    # Act
    fill_in 'Name', with: 'Engineering'
    click_on 'Update'

    # Assert
    expect(page).to have_current_path(organisation_team_path(organisation, team))
    expect(page).to have_content('Engineering')
  end
end
