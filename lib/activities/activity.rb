# frozen_string_literal: false

# top level comment
class Activity
  @klasses = []

  class << self
    attr_reader :klasses
  end

  def self.factory(args)
    raise ArgumentError, ':type is a required argument' if args[:type].nil?

    s = args[:type]
    activity_class = klasses.find do |klass|
      klass.name.eql? s
    end
    activity_class.new(args)
  end

  def execute
    error_text = "#{self.class} did not implement execute method"
    raise NotImplementedError, error_text
  end

  def log
    error_text = "#{self.class} did not implement log method"
    raise NotImplementedError, error_text
  end
end
