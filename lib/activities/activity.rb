# frozen_string_literal: false

# top level comment
class Activity
  @klasses = []

  attr_reader :timestamp, :username, :pid, :command_line

  class << self
    attr_reader :klasses, :username, :pid, :command_line
    attr_accessor :logger
  end

  def self.set_process_info(username:, pid:, command_line:)
    puts "command_line #{command_line}"
    @username = username
    @pid = pid
    @command_line = command_line
  end

  def self.process_name
    command_line.split('/').last
  end

  def self.inherited(subclass)
    @klasses << subclass
    super
  end

  def self.factory(args)
    raise ArgumentError, ':type is a required argument' if args[:type].nil?

    s = args[:type]
    activity_class = klasses.find do |klass|
      klass if klass.answers? s
    end

    if activity_class.nil?
      error_text = "#{s} was not found. You must create a subclass of activity in the configuration file."
      raise NotImplementedError, error_text
    end
    activity_class.new(args)
  end

  def answers?(_type)
    error_text = "#{self.class} did not implement answers? method"
    raise NotImplementedError, error_text
  end

  def mark_time
    @timestamp = Time.now.utc
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
