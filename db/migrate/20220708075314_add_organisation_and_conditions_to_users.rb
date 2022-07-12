# frozen_string_literal: true

class AddOrganisationAndConditionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :job_title, :string
    add_column :users, :phone_number, :string
    add_column :users, :accepted_terms_and_conditions, :boolean, default: false
    add_column :users, :agreed_to_receive_updates_newsletters_and_marketing, :boolean, default: false
  end
end
