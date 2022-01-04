require_relative 'bumpversion/version'
require_relative 'bumpversion/parser'
require_relative 'bumpversion/parser_file'
require_relative 'bumpversion/bump_string'
require_relative 'bumpversion/reader'
require_relative 'bumpversion/writer'
require_relative 'bumpversion/git_operation'
require_relative 'bumpversion/hook'
require_relative 'bumpversion/pretty_output'

module Bumpversion
  class Bumpversion
    def initialize(arguments = nil)
      PrettyOutput.start("Bump your project ... ☺ ")
      @options = {}

      PrettyOutput.begin("Parsing Options Start")
      parser = Parser.new @options, arguments
      @options = parser.parse
      PrettyOutput.success("Done!")

      PrettyOutput.begin("Parsing File Start")
      parser_file = ParseFile.new @options
      @options = parser_file.parse
      PrettyOutput.success("Done!")

      PrettyOutput.begin("Bump String")
      bump_string = BumpString.new @options
      @options = bump_string.bump
      PrettyOutput.success("Done!")

      @git = GitOperation.new @options
    end

    def run
      PrettyOutput.begin("Reading Files")
      reader = Reader.new @options
      PrettyOutput.success("Done!")

      PrettyOutput.begin("Writing Files")
      writer = Writer.new @options, reader
      writer.write!
      PrettyOutput.success("Done!")

      PrettyOutput.begin("Pre Commit Hooks")
      Hook.pre_commit_hook @options
      PrettyOutput.success("Done!")

      if @options[:git_commit] || @options[:git_tag] || @options[:git_push]
        PrettyOutput.begin("Git Operations")
        @git.do!
        PrettyOutput.success("Done!")
      end

      PrettyOutput.begin("Pos Commit Hooks")
      Hook.pos_commit_hook @options
      PrettyOutput.success("Done!")

      PrettyOutput.finish("Your project was Bumped with success! #{@options[:current_version]} → #{@options[:new_version]} ☺ ")
    end
  end
end
