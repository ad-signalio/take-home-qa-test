# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    organisation

    sequence :name do |n|
      "#{Faker::Team.name} #{n}"
    end
  end
end
