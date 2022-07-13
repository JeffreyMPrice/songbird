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
    path + "/files/" + file
  end

  def execute
    # TO DO - If time were not an issue, would do better here
    case action
    when 'create'
      create
    when 'modify'
      modify
    when 'delete'
      delete
    else
      raise NotImplementedError, "FileActivity does not understand #{action}"
    end
    log
  end

  def log
    puts 'Process Log'
  end

  def create
    File.open(filename, "w") {|f| f.write("\nMade by Jeff")}
  end

  def delete
    File.delete(filename)
  end

  def modify
    File.open(filename, "a") {|f| f.write("\nModified by Jeff")}
  end
end
