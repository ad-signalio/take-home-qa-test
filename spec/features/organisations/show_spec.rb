# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisations show', type: :feature do
  let(:organisation) { create :organisation }
  let!(:team) { create :team, organisation: organisation }

  it 'navigate to create a new team page for the organisation' do
    # Arrange
    visit organisation_path(organisation)

    # Act
    click_on 'New Team'

    # Assert
    expect(page).to have_current_path(new_organisation_team_path(organisation))
  end

  it 'navigate to the show page of an existing team on the organisation' do
    # Arrange
    visit organisation_path(organisation)

    # Act
    within("[data-test-id='team_#{team.id}_row']") do
      click_on 'Show'
    end

    # Assert
    expect(page).to have_current_path(organisation_team_path(organisation, team))
  end

  it 'navigate to the edit page of an existing team on the organisation' do
    # Arrange
    visit organisation_path(organisation)

    # Act
    within("[data-test-id='team_#{team.id}_row']") do
      click_on 'Edit'
    end

    # Assert
    expect(page).to have_current_path(edit_organisation_team_path(organisation, team))
  end

  it 'destroy organisations team' do
    # Arrange
    visit organisation_path(organisation)

    # Act
    within("[data-test-id='team_#{team.id}_row']") do
      click_on 'Destroy'
    end

    # Assert
    expect(page).to have_current_path(organisation_path(organisation))
    expect(page).not_to have_content(team.name)
  end
end
