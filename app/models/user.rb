# frozen_string_literal: true

class User < ApplicationRecord
  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :registerable

  belongs_to :organisation, required: false

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: Devise.email_regexp }
  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 9 }
  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { minimum: 9, maximum: 255 }

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
