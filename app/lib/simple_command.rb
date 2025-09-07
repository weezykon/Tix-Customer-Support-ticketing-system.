module SimpleCommand
  def self.prepended(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  module InstanceMethods
    attr_reader :errors, :result

    def initialize(*_args)
      @errors = ActiveModel::Errors.new(self)
    end

    def success?
      errors.none?
    end

    def failure?
      errors.any?
    end
  end
end