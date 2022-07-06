# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisations index', type: :feature do
  let!(:organisation) { create :organisation }

  it 'navigate to create a new organisation page' do
    # Arrange
    visit organisations_path

    # Act
    click_on 'New Organisation'

    # Assert
    expect(page).to have_current_path(new_organisation_path)
  end

  it 'navigate to the show page of an existing organisation' do
    # Arrange
    visit organisations_path

    # Act
    within("[data-test-id='organisation_#{organisation.id}_row']") do
      click_on 'Show'
    end

    # Assert
    expect(page).to have_current_path(organisation_path(organisation))
  end

  it 'navigate to the edit page of an existing organisation' do
    # Arrange
    visit organisations_path

    # Act
    within("[data-test-id='organisation_#{organisation.id}_row']") do
      click_on 'Edit'
    end

    # Assert
    expect(page).to have_current_path(edit_organisation_path(organisation))
  end

  it 'destroy organisation' do
    # Arrange
    visit organisations_path

    # Act
    within("[data-test-id='organisation_#{organisation.id}_row']") do
      click_on 'Destroy'
    end

    # Assert
    expect(page).to have_current_path(organisations_path)
    expect(page).not_to have_content(organisation.name)
  end
end
