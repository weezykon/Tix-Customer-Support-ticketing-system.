# frozen_string_literal: true

# Represents a comment on a support ticket.
class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
end
