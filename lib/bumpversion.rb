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
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Parsing File Start")
      parser_file = ParseFile.new @options
      @options = parser_file.parse
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Bump String")
      bump_string = BumpString.new @options
      @options = bump_string.bump
      PrettyOutput.sucess("Done!")
      @git = GitOperation.new @options
    end

    def run
      PrettyOutput.begin("Reading Files")
      reader = Reader.new @options
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Writing Files")
      writer = Writer.new @options, reader
      writer.write!
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Pre Commit Hooks")
      Hook.pre_commit_hook @options
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Git Operations")
      @git.do!
      PrettyOutput.sucess("Done!")

      PrettyOutput.begin("Pos Commit Hooks")
      Hook.pos_commit_hook @options
      PrettyOutput.sucess("Done!")

      PrettyOutput.finish("Your project was Bumped with sucess! #{@options[:current_version]} → #{@options[:new_version]} ☺ ")
    end
  end
end
