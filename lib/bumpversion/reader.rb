module Bumpversion
  class Reader
    def initialize(options)
      @options = options
      @files_to_write = []
    end

    attr_reader :files_to_write

    def validate!
      files_to_write.each do |file_to_write|
        raise "Current Version not found in #{file_to_write[:filename]} file" unless file_to_write[:content].include? @options[:current_version]
      end
    end

    def reader!
      files_to_read = @options[:file].split(",")
      files_to_read.each do |file_to_read|
        files_to_write << {
          filename: file_to_read,
          content: File.read(file_to_read)
        }
      end

      validate!
    end
  end
end
