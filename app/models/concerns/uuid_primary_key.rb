# frozen_string_literal: true

# A concern for models that use UUIDs as primary keys.
module UuidPrimaryKey
  extend ActiveSupport::Concern

  included do
    before_create :generate_uuid
    self.primary_key = :id
  end

  def generate_uuid
    self.id ||= SecureRandom.uuid
  end
end
