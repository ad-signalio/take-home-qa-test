# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    sequence(:password) { |i| "Password#{i}" }

    accepted_terms_and_conditions { true }
    agreed_to_receive_updates_newsletters_and_marketing { true }

    organisation
  end
end
