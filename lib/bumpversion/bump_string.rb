module Bumpversion
  class BumpString
    def initialize(options)
      @options = options
    end

    def dictionary
      { major: 1, minor: 2, patch: 3 }
    end

    def key_part
      @options[:part].to_sym
    end

    def pattern
      /([0-9]+)\.([0-9]+)\.([0-9]+)/
    end

    def matched
      match = pattern.match(@options[:current_version])
      matched = {}
      dictionary.each { |part, number| matched[part] = match[number].to_i }
      matched
    end

    def update_version(matched_version)
      bumped = false
      matched_version.each do | part, number |
        matched_version[part] = 0 if bumped

        if part == key_part
          matched_version[part] += 1
          bumped = true
        end
      end

      matched_version
    end

    def bump
      unless @options[:new_version]
        matched_version = update_version(matched)
        new_version_hash = matched_version.map { |_key, value| value.to_s }
        @options[:new_version] = new_version_hash.join('.')
      end
      @options
    end
  end
end
