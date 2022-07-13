# frozen_string_literal: false

# top level comment
class NetworkActivity < Activity
  def initialize(_args)
    super()
  end

  def self.answers?(type)
    type.eql? 'network'
  end

  def execute
    puts 'Process Execute'
  end

  def log
    puts 'Process Log'
  end
end
