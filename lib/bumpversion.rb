require_relative 'bumpversion/version'
require_relative 'bumpversion/parser'
require_relative 'bumpversion/parser_file'
require_relative 'bumpversion/bump_string'
require_relative 'bumpversion/reader'
require_relative 'bumpversion/writer'
require_relative 'bumpversion/git_operation'
require 'colorize'

module Bumpversion
  class Bumpversion
    def initialize(arguments = nil)
      parser = Parser.new @options, arguments
      @options = parser.parse
      parser_file = ParseFile.new @options
      @options = parser_file.parse
      bump_string = BumpString.new @options
      @options = bump_string.bump
      @git = GitOperation.new @options
    end

    def run
      p "Reading files ..."
      reader = Reader.new @options
      writer = Writer.new @options, reader
      writer.write!
      p "Bumped as Sucessfull!" if writer
      @git.do!
    end
  end
end
