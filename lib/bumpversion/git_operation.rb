require 'git'

module Bumpversion
  class GitOperation
    def initialize(options)
      @options = options
      @git = Git.init
      Git.init('.')
    end

    def config!
      @git.config('user.name', @options[:git_user])
      @git.config('user.email', @options[:git_email])
    end

    def commit!
      if @options[:git_commit]
        file = @options[:file].split(',') + [@options[:config_file]]
        file += @options[:git_extra_add].split(',') if @options[:git_extra_add]
        @git.add(file)
        @git.commit("Bump version: #{@options[:current_version]} → #{@options[:new_version]}")
      end
    end

    def tag!
      @git.add_tag("v#{@options[:new_version]}") if @options[:git_tag]
    end

    def push!
      @git.push if @options[:git_push]
      @git.push(@git.remote.name, @git.branch.name, :tags => true) if @options[:git_push] && @options[:git_tag]
    end

    def do!
      config!
      commit!
      tag!
      push!
    end
  end
end
