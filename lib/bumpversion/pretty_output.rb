require 'colorize'

module Bumpversion
  class PrettyOutput
    def self.start(msg)
      puts "→ #{msg}".white
    end

    def self.finish(msg)
      puts "→ #{msg}".white
    end

    def self.begin(msg)
      puts "  → #{msg}".blue
    end

    def self.info(msg)
      puts "    → #{msg}".blue
    end

    def self.sucess(msg)
      puts "      → #{msg} √".green
    end

    def self.error(msg)
      puts "      → #{msg} ✖".red
    end
  end
end
