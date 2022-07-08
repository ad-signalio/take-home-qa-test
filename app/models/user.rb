# frozen_string_literal: true

class User < ApplicationRecord
  after_create :send_welcome_email

  attr_accessor :skip_password_validation, :complete_registration_validation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :registerable

  belongs_to :organisation, optional: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: Devise.email_regexp }
  validates :first_name,
            presence: true,
            length: { maximum: 255 }
  validates :last_name,
            presence: true,
            length: { minimum: 9, maximum: 255 }

  validates :phone_number,
            allow_nil: true,
            length: { maximum: 15 },
            format: { with: /\A[0-9+\s]*\z/ }
  validates :organisation_id,
            presence: true,
            if: :complete_registration_validation
  validates :accepted_terms_and_conditions,
            presence: { message: 'You must to agree to the terms and conditions to continue' },
            if: :complete_registration_validation
  validates :agreed_to_receive_updates_newsletters_and_marketing,
            inclusion: [true, false],
            if: :complete_registration_validation

  protected

  def password_required?
    return false if skip_password_validation

    super
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
