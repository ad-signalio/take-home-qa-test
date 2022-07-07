# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register new user', type: :feature, js: true do
  context 'Happy path' do
    let(:user) do
      create(:user, :with_super_admin_role, accepted_terms_and_conditions: false,
                                            agreed_to_receive_updates_newsletters_and_marketing: false)
    end

    before do
      sign_in(user)

      visit '/'
    end

    it 'redirects the user to the accept terms and conditions page' do
      expect(page).to have_content('Terms and Conditions')
      expect(page).to have_current_path('/terms_and_conditions')
    end

    it 'does not allow the user to proceed until they have accepted terms and conditions' do
      click_button('Update')
      expect(page).to have_current_path('/terms_and_conditions')
      expect(page).to have_content('You must to agree to the terms and conditions to continue')
    end

    it 'redirects the user to the root path on accepting the terms' do
      check 'I agree to the Terms and Conditions'

      click_button('Update')
      expect(page).to have_current_path('/')
      expect(page).not_to have_content('Terms and Conditions')
    end

    context 'when the user wishes to receive marketing info' do
      it 'sets agreed_to_receive_updates_newsletters_and_marketing for the user' do
        check 'I agree to the Terms and Conditions'
        check 'I agree to receive general updates, newsletters and marketing'

        click_button('Update')

        expect(page).to have_current_path('/')
        expect(page).not_to have_content('Terms and Conditions')

        user.reload
        expect(user).to have_attributes(
          accepted_terms_and_conditions: true,
          agreed_to_receive_updates_newsletters_and_marketing: true
        )
      end
    end
  end
end
