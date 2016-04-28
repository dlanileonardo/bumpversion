require 'trollop'
require 'bumpversion/version'

module Bumpversion
  class Parser
    def initialize(options, arguments = nil)
      @args = arguments || ARGV
      @options = options
    end

    def mount_banner
      version_number = VERSION
      Trollop::Parser.new do
        version "Bumpversion #{version_number} ☺"
        usage "bumpversion [options] --part [major|minor|patch]
        where [options] are:"

        banner <<-EOS
#{version}

Usage:
#{usage}
        EOS

        opt :help, 'Show this help!'
        opt :part, 'The part of the version to increase, [major, minor, patch]', default: 'minor'
        opt :file, 'The file that will be modified can be multi-files separated by comma.
          Example: VERSION, GEMNAME.gemspec, version.rb', default: 'VERSION', type: :string
        opt :config_file, 'The file contains config this program', default: '.bumpversion.cfg', type: :string
        opt :current_version, 'The current version of the software package before bumping ', type: :string
        opt :new_version, 'The version of the software package after the increment. \
        If not given will be automatically determined.', required: false, type: :string

        opt :git_commit, 'Whether to create a commit using Git.', required: false, default: false, type: :boolean
        opt :git_tag, 'Whether to create a tag, that is the new version, prefixed with the character "v". If you are using git',
            required: false, default: false, type: :boolean
        opt :git_push, 'Pushes Tags and Commit to origin Git', reuired: false, default: false, type: :boolean
        opt :git_user, 'Name from User to Create Commit', required: false, default: "Auto Bump", type: :string
        opt :git_email, 'Email from User to Create Email', required: false, default: "auto@bump.io", type: :string
        opt :git_extra_add, 'Extra files to add in git commit', required: false, default: "", type: :string

        opt :pre_commit_hooks, 'Call sh commands before commits after Bumpversion separated by ;',
            required: false, type: :string
        opt :pos_commit_hooks, 'Call sh commands after commits separated by ;',
            required: false, type: :string
      end
    end

    def parse
      banner = mount_banner
      @options = Trollop.with_standard_exception_handling banner do
        fail Trollop::HelpNeeded if @args.empty?
        banner.parse @args
      end

      Trollop.die if @options[:help]

      @options
    end
  end
end
