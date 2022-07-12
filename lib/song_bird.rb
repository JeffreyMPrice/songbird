# frozen_string_literal: false

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
