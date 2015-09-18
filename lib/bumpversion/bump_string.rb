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

  def key_number
    dictionary[key_part]
  end

  def pattern
    /([0-9]+)\.([0-9]+).([0-9]+)/
  end

  def matched
    match = pattern.match(@options[:current_version])
    matched = {}
    dictionary.each { |part, number| matched[part] = match[number].to_i }
    matched
  end

  def bump
    unless @options[:new_version]
      matched_version = matched
      matched_version[key_part] += 1
      new_version_hash = matched_version.map { |_key, value| value.to_s }
      @options[:new_version] = new_version_hash.join('.')
    end

    @options
  end
end
