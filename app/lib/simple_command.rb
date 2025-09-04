# frozen_string_literal: true

module SimpleCommand
  extend ActiveSupport::Concern
  # A simple command pattern implementation.
  

  module ClassMethods
    # Class methods for SimpleCommand.
    def call(*args)
      new(*args).call
    end
  end

  module InstanceMethods
    # Instance methods for SimpleCommand.
    attr_reader :errors

    def initialize
      @errors = ActiveModel::Errors.new(self)
    end

    def success?
      errors.none?
    end

    def failure?
      errors.any?
    end

    def self.included(base)
      base.include ActiveModel::Model
    end
  end

  prepend SimpleCommand::ClassMethods
  include SimpleCommand::InstanceMethods
end
