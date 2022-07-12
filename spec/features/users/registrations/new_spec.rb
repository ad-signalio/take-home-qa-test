# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register new user', type: :feature, js: true do
  let!(:organisation) { create(:organisation) }

  context 'when going through the first step of self registration' do
    before do
      visit '/users/sign_up'
    end

    it 'Displays the sign up page' do
      expect(page).to have_content('Sign up')
      expect(page).to have_current_path('/users/sign_up')
    end

    it 'Requires all the fields on the page' do
      click_button('Sign up')

      expect(page).to have_content('Email can\'t be blank')
      expect(page).to have_content('Email is invalid')
      expect(page).to have_content('Password can\'t be blank')
      expect(page).to have_content('First name can\'t be blank')
      expect(page).to have_content('Last name can\'t')
    end

    it 'Redirects to the complete registration page on filling the relevant info' do
      password = Faker::Lorem.characters(number: 10)
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Lorem.characters(number: 10)
      find('#user_password').fill_in with: password
      fill_in 'Password confirmation', with: password
      click_button('Sign up')

      expect(page).to have_current_path("/users/registrations/complete/#{User.last.id}")
      expect(page).to have_content('Complete registration')
    end
  end

  context 'when going through he second step of self registration' do
    let(:user) do
      create(:user, accepted_terms_and_conditions: false,
                    agreed_to_receive_updates_newsletters_and_marketing: false)
    end

    before do
      sign_in(user)

      visit '/'
    end

    it 'redirects the user to the complete registration page' do
      expect(page).to have_content('Complete registration')
      expect(page).to have_current_path("/users/registrations/complete/#{user.id}")
    end

    it 'does not allow the user to proceed until they have accepted terms and conditions' do
      click_button('Complete')
      expect(page).to have_current_path("/users/registrations/complete/#{user.id}")
      expect(page).to have_content('You must to agree to the terms and conditions to continue')
    end

    it 'does not allow the user to proceed unless they have selected an organisation' do
      check 'I agree to the Terms and Conditions'

      click_button('Complete')
      expect(page).to have_current_path("/users/registrations/complete/#{user.id}")
      expect(page).to have_content('Organisation can\'t be blank')
    end

    it 'redirects the user to the root path on selecting the organisation and accepting the terms' do
      select organisation.name, from: 'Organisation'
      check 'I agree to the Terms and Conditions'

      click_button('Complete')
      expect(page).to have_current_path('/')
      expect(page).not_to have_content('Complete registration')
    end

    context 'when the user wishes to receive marketing info' do
      it 'sets agreed_to_receive_updates_newsletters_and_marketing for the user' do
        select organisation.name, from: 'Organisation'
        check 'I agree to the Terms and Conditions'
        check 'I agree to receive general updates, newsletters and marketing'

        click_button('Complete')

        expect(page).to have_current_path('/')
        expect(page).not_to have_content('Complete registration')

        user.reload
        expect(user).to have_attributes(
          accepted_terms_and_conditions: true,
          agreed_to_receive_updates_newsletters_and_marketing: true
        )
      end
    end
  end
end
