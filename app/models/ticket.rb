# frozen_string_literal: true

require 'csv'

# Represents a support ticket.
class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_agent, class_name: 'User', optional: true
  has_many :comments
  has_many_attached :attachments

  validates :status, inclusion: { in: %w[open in_progress closed], message: '%<value>s is not a valid status' }
  validates :priority, presence: true, inclusion: { in: %w[low medium high], message: '%<value>s is not a valid priority' }
  validates :department, presence: true
  validates :subject, presence: true

  def self.to_csv
    attributes = %w[id title description status priority department subject user_id assigned_agent_id created_at updated_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |ticket|
        csv << attributes.map { |attr| ticket.send(attr) }
      end
    end
  end
end
