# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Ad-Signal Orgsanisation, teams and users
ad_signal = Organisation.find_or_initialize_by(name: 'Ad Signal')
ad_signal.save! if ad_signal.changed?

test_users = [
  { email: 'test-user@test.co.uk', first_name: 'Test', last_name: 'NewTestUser' }
]

test_users.each do |user_details|
  test_user = User.find_or_initialize_by(
    email: user_details[:email]
  )

  if test_user.new_record?
    test_user.password = '123Password!'
    test_user.first_name = user_details[:first_name]
    test_user.last_name = user_details[:last_name]
    test_user.organisation = ad_signal
    test_user.save!
  end
end
