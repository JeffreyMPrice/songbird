# frozen_string_literal: false

require_relative 'activities/activity'
Dir[File.join(__dir__, 'activities', '*.rb')].sort.each { |file| require file }

# top level comment
class SongBird
  attr_reader :activities, :path

  def initialize(args)
    a = args[:activities]
    p = args[:path]
    raise ArgumentError, 'SongBird requires a set of activities to execute' unless a
    raise ArgumentError, 'SongBird requires a path for the work directory' unless p

    @activities = a
    @path = p
  end

  def execute
    a = activities.map do |activity|
      type = activity.keys[0]
      activity_args = activity[type]
      activity_args[:type] = type
      activity_args[:path] = path
      act = Activity.factory(activity_args)
    end
    a.each do |activity|
      activity.execute
    end
  end
end
