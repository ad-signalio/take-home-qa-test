class AddOrganisationReferenceToTeams < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :organisation, foreign_key: true
  end
end
