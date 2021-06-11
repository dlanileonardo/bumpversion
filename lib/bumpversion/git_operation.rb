require 'git'

module Bumpversion
  class GitOperation
    def initialize(options)
      @options = options
      @git = Git.init
      Git.init('.')
    end

    def commit!
      if @options[:git_commit]
        PrettyOutput.info("git commit")
        file = @options[:file].split(',') + [@options[:config_file]]
        file += @options[:git_extra_add].split(',') if @options[:git_extra_add]
        @git.add(file)
        @git.commit("Bump version: #{@options[:current_version]} → #{@options[:new_version]}", {author: "#{@options[:git_user]} <#{@options[:git_email]}>"})
      end
    end

    def tag!
      if @options[:git_tag]
        PrettyOutput.info("git tag")
        @git.add_tag("v#{@options[:new_version]}")
      end
    end

    def push!
      if @options[:git_push]
        @git.push
        if @options[:git_tag]
          PrettyOutput.info("git push with tags")
          @git.push(@git.remote.name, @git.branch.name, :tags => true)
        else
          PrettyOutput.info("git push")
        end
      end
    end

    def do!
      commit!
      tag!
      push!
    end
  end
end
