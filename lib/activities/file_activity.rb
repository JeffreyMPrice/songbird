# frozen_string_literal: false

# top level comment
class FileActivity < Activity
  attr_reader :file, :action, :path

  def initialize(args)
    @file = args['file']
    @action = args['action']
    @path = args[:path]
    super()
  end

  def self.answers?(type)
    type.eql? 'file'
  end

  def filename
    "#{path}/files/#{file}"
  end

  def execute
    mark_time

    send(action)
  end

  def log
    log = { action: 'File Activity',
            timestamp: timestamp,
            full_path: filename,
            activity: action,
            calling_username: Activity.username,
            calling_process_name: Activity.process_name,
            calling_pid: Activity.pid,
            calling_command_line: Activity.command_line }
    Activity.logger.info(log.to_json)
  end

  def create
    File.open(filename, 'w') { |f| f.write("\nMade by Jeff") }
  end

  def delete
    File.delete(filename)
  end

  def modify
    File.open(filename, 'a') { |f| f.write("\nModified by Jeff") }
  end
end
