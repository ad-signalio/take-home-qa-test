# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: %i[create]
    before_action :configure_account_update_params, only: %i[update complete]
    before_action :check_user_registration_complete
    prepend_before_action :authenticate_scope!, only: %i[edit update destroy details complete]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    def details
      render :complete
    end

    def complete # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource.skip_password_validation = true
      resource.complete_registration_validation = true

      resource_updated = resource.update(account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        redirect_to root_path
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    def check_user_registration_complete
      return if current_user.blank?

      redirect_to root_path if current_user.accepted_terms_and_conditions?
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(
        :account_update,
        keys: %i[first_name last_name job_title phone_number organisation_id
                 accepted_terms_and_conditions
                 agreed_to_receive_updates_newsletters_and_marketing]
      )
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
