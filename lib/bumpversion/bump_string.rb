module Bumpversion
  class BumpString
    def initialize(options)
      @options = options
    end

    def dictionary
      %w[major minor patch build].map { |k| k.to_sym }
    end

    def key_part
      @options[:part].to_sym
    end

    def pattern
      /(?<major>\d+).(?<minor>\d+).(?<patch>\d+).?(?<build>\d+)?/
    end

    def pattern_replace
      /(?<major>\d+)(?<a>.)(?<minor>\d+)(?<b>.)(?<patch>\d+)(?<c>.)?(?<build>\d+)?/
    end

    def matched
      @match ||= pattern.match(@options[:current_version])
    end

    def update_version(matched_version)
      bumped = false
      matched_version.each do | part, number |
        matched_version[part] = 0 if bumped && part.to_sym != :build

        if part.to_sym == key_part || part.to_sym == :build
          matched_version[part] += 1
          bumped = true
        end
      end

      matched_version
    end

    def bump
      unless @options[:new_version]
        actual_version = matched.named_captures.reject { |k,v| v.nil? }.map { |k, v| [k.to_sym, v.to_i] }.to_h
        matched_version = update_version(actual_version)
        new_version = pattern_replace.match(@options[:current_version]).named_captures.map do |k, v|
          dictionary.include?(k.to_sym) ? "#{matched_version[k.to_sym]}" : v || ""
        end.join("")
        @options[:new_version] = new_version
      end
      @options
    end
  end
end
