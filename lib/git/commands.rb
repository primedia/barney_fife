require 'open3'

module Git
  class Commands
    include Anima.new(:name, :organization)

    def ensure_base_dir
      mkdir(storage_dir)
    end

    def is_repo?(path = repo_dir)
      ensure_base_dir
      return false unless Dir.exists?(path)
      chdir(repo_dir) do
        system("git rev-parse")
      end
    end

    def clean_up
      # prune and optimize
      cmd("git gc")
    end

    def clone
      mkdir(name)
      cmd("git clone #{github_url} #{full_name}")
    end

    def pull
      reset
      cmd("git pull")
    end

    def reset
      cmd("git reset --hard && git clean -df")
      clean_up
    end

    def fetch_all
      fetch("--all")
    end

    def checkout_default_branch
      checkout(default_branch)
    end

    def default_branch
      @default_branch ||= GitHub::Client.repository(full_name).default_branch
    end

    def fetch(opt = '')
      string = ["git fetch", opt].join(' ')
      cmd(string)
    end

    def checkout(ref)
      cmd("git checkout #{ref}")
    end

    def add(options = '--all')
      cmd("git add #{options}")
    end

    def commit(message)
      cmd("git commit -m #{message}")
    end

    def github_url
      "git@github.com:#{full_name}.git"
    end

    def full_name
      "#{organization}/#{name}"
    end

    def cmd(shell_command)
      stdout, stderr, status = Open3.capture3(shell_command)
      [stdout.chomp, stderr.chomp, status]
    end

    def mkdir(dir)
      Dir.mkdir(dir) unless Dir.exists?(dir)
    end

    def chdir(dir = storage_dir, &block)
      Dir.chdir(File.expand_path(dir)) do
        yield
      end
    end

    def storage_dir
      Rails.configuration.repo_dir
    end

    def repo_dir
      File.join(storage_dir, full_name)
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
