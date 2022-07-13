# frozen_string_literal: false

require_relative 'activities/activity'
Dir[File.join(__dir__, 'activities', '*.rb')].sort.each { |file| require file }

# top level comment
class SongBird
  attr_reader :activities, :path

  def initialize(args)
    raise ArgumentError, 'SongBird requires a set of activities to execute' unless args[:activities]
    raise ArgumentError, 'SongBird requires a path for the work directory' unless args[:path]

    a = args[:activities]
    p = args[:path]

    @activities = a
    @path = p
  end

  def execute
    a = activities.map do |activity|
      type = activity.keys[0]
      activity_args = activity[type]
      activity_args[:type] = type
      activity_args[:path] = path
      Activity.factory(activity_args)
    end
    a.each(&:execute)
  end
end
