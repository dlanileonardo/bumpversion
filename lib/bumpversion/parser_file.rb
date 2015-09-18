require 'parseconfig'

class ParseFile
  def initialize(options)
    @options = options
  end

  def parse
    return @options unless File.exist?('.bumpversion')
    config = ParseConfig.new('.bumpversion')
    merge(@options, config['bumpversion']) if config && config['bumpversion']
  end

  def merge(options, parseconfig)
    parseconfig.each do |key, value|
      key = key.tr('-', '_')
      key_given = "#{key}_given"
      key_given_file = "#{key_given}_file"

      unless options[key_given.to_sym]
        options[key.to_sym] = value
        options[key_given_file.to_sym] = value
      end
    end
    options
  end
end
