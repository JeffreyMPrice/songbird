# frozen_string_literal: false

# top level comment
class ProcessActivity < Activity
  def initialize(args)
    super()
  end

  def self.answers?(type)
    type.eql? 'process'
  end

  def execute
    puts 'Process Execute'
  end

  def log
    puts 'Process Log'
  end
end
