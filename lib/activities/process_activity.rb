# frozen_string_literal: false

# top level comment
class ProcessActivity < Activity
  attr_reader :executable, :arguments, :pid

  def initialize(args)
    raise ArgumentError, 'ProcessActivity must have an executable' unless args['executable']

    @executable = args['executable']
    @arguments = args['arguments'] || []

    super()
  end

  def command_line
    cl = executable
    cl = "#{cl} #{arguments.join(' ')}" if arguments
    cl
  end

  def self.answers?(type)
    type.eql? 'process'
  end

  def execute
    mark_time
    @pid = spawn(command_line)
  end

  def log
    log = { action: 'Process Activity',
            timestamp: timestamp,
            process_name: executable,
            process_arguments: arguments,
            process_id: pid,
            calling_username: Activity.username,
            calling_process_name: Activity.process_name,
            calling_pid: Activity.pid,
            calling_command_line: Activity.command_line }
    Activity.logger.info(log.to_json)
  end
end
