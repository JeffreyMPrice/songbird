# frozen_string_literal: false

require_relative 'activities/activity'
Dir[File.join(__dir__, 'activities', '*.rb')].sort.each { |file| require file }

# top level comment
class SongBird
  attr_reader :activities

  def initialize(activities)
    raise ArgumentError, 'SongBird requires a set of activities to execute' unless activities

    @activities = activities
  end

  def execute
    puts activities.to_s
  end
end
