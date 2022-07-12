# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :check_user_registration_complete, unless: :devise_controller?

  private

  def check_user_registration_complete
    return if current_user.blank?

    redirect_to complete_user_registration_path(current_user) unless current_user.accepted_terms_and_conditions?
  end
end
