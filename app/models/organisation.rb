# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :teams, dependent: :destroy
end
