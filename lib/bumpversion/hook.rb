
module Bumpversion
  class Hook
    def self.call_system(key_hook, options)
      return false unless options[key_hook]
      command = options[key_hook] % options
      PrettyOutput.info "Executing command: #{command}"
      system("#{command} 1> /dev/null") if command
    end

    def self.pos_commit_hook(options)
      call_system(:pos_commit_hooks, options)
    end

    def self.pre_commit_hook(options)
      call_system(:pre_commit_hooks, options)
    end
  end
end
