# frozen_string_literal: false

require 'fileutils'
require 'pathname'
require 'json'

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = %w[--display-cop-names -a]
  end
rescue LoadError
  puts 'No RuboCop available'
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError
  puts 'No rspec available'
end

task build: :clean do
  Pathname('work/files').mkpath
  Pathname('work/log').mkpath
  FileUtils.copy('data/files/thanks_for_all_the_fish.txt', 'work/files/')
end

task run: :build do
  require_relative 'lib/song_bird'
  activities = JSON.parse(File.read('activities.json'))
  sb = SongBird.new(activities: activities, path: File.expand_path('work'))
  sb.execute
end

task :clean do
  FileUtils.rm_rf('work')
end
