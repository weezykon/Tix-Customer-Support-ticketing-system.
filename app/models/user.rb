# frozen_string_literal: true

# Represents a user in the system, either a customer or an agent.
class User < ApplicationRecord
  has_secure_password

  has_many :tickets
  has_many :comments

  validates :role, inclusion: { in: %w[customer agent], message: '%<value>s is not a valid role' }
end
