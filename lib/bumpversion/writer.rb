module Bumpversion
  class Writer
    def initialize(options, reader)
      @options = options
      @reader = reader
    end

    def reader_files
      @reader.reader!
      @reader.files_to_write
    end

    def content_config_file
      @content_config_file ||= File.read(@options[:config_file])
    end

    def validate!
      file_exists = File.exist? @options[:config_file]
      file_has_current_version = (file_exists && content_config_file.include?("current-version"))
      file_current_version_match = file_has_current_version && content_config_file.include?(@options[:current_version])
      valid = !file_exists || !file_has_current_version || file_current_version_match

      raise "Version File does not Match with Current Version" unless valid
    end

    def update_config_file!
      new_content = content_config_file.gsub(@options[:current_version], @options[:new_version])
      File.write(@options[:config_file], new_content)
    end

    def write!
      reader_files.each do |file_to_write|
        validate!

        new_content = file_to_write[:content].gsub(@options[:current_version], @options[:new_version])
        File.write(file_to_write[:filename], new_content)

        update_config_file!
      end
    end
  end
end
