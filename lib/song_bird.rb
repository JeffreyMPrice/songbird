# frozen_string_literal: false

require 'logger'
require 'json'

require_relative 'activities/activity'
Dir[File.join(__dir__, 'activities', '*.rb')].sort.each { |file| require file }

# top level comment
class SongBird
  attr_reader :activities, :path, :logger

  def initialize(args)
    raise ArgumentError, 'SongBird requires a set of activities to execute' unless args[:activities]
    raise ArgumentError, 'SongBird requires a path for the work directory' unless args[:path]

    a = args[:activities]
    p = args[:path]

    @activities = a
    @path = p
    @logger = Logger.new("#{p}/log/songbird_#{Time.now.utc.strftime('%m%d%Y_%H%M%S')}.log")
  end

  def set_activity
    Activity.set_process_info(username: ENV['USER'], pid: Process.pid, command_line: Process.argv0)
    Activity.logger = @logger
  end

  def execute
    set_activity

    a = activities.map do |activity|
      type = activity.keys[0]
      activity_args = activity[type]
      activity_args[:type] = type
      activity_args[:path] = path
      Activity.factory(activity_args)
    end
    a.each(&:execute)
    a.each(&:log)
  end

  def kill_all(activities)
    activities.each do |activity|
      # this won't work on windows, but windows ping behaves
      Process.kill('TERM', activity.pid) if activity.pid
    end
  end
end
