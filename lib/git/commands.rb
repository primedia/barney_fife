require 'open3'

module Git
  class Commands
    include Anima.new(:repo_full_name)

    def clone
      cmd("git clone #{github_url}")
    end

    def pull
      cmd("git pull")
    end

    def fetch
      cmd("git fetch")
    end

    def add(options = '--all')
      cmd("git add #{options}")
    end

    def commit(message)
      cmd("git commit -m #{message}")
    end

    def github_url
      "git@github.com:#{repo_full_name}.git"
    end

    def cmd(shell_command)
      stdout, stderr, status = Open3.capture3(shell_command)
      [stdout.chomp, stderr.chomp, status]
    end

    def tmp(dir='~/tmp', &block)
      Dir.chdir(File.expand_path(dir)) do
        yield
      end
    end

    def tmp_dir(&block)
      Dir.mktmpdir do |tmp|
        Dir.chdir(tmp) do
          yield
        end
      end
    end
  end
end
