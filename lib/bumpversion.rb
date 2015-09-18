require_relative 'bumpversion/version'
require_relative 'bumpversion/parser'
require_relative 'bumpversion/parser_file'
require_relative 'bumpversion/bump_string'
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
    end

    def run
      # p "Reading files ..."
      # reader = Reader.new @options
      # writer = Writer.new @options, reader
      # p "Bumped as Sucessfull!".green if writer
    end
  end
end
