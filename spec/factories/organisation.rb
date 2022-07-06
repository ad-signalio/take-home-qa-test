# frozen_string_literal: true

FactoryBot.define do
  factory :organisation do
    sequence :name do |n|
      "#{Faker::Company.name} #{n}"
    end
  end
end
