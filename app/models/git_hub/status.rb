module GitHub
  class Status
    CONTEXT = 'code-quality/barney-fife'
    BETA_HEADER = 'application/vnd.github.she-hulk-preview+json'

    attr_reader :repo, :sha, :client

    def initialize(repo, sha, client = GitHub::Client)
      @repo, @sha, @client = repo, sha, client
    end

    def pending!
      set_status('pending')
    end

    def success!
      set_status('success')
    end

    def failure!
      set_status('failure')
    end

    def error!
      set_status('error')
    end

    private

    def set_status(state)
      client.create_status(repo, sha, state, context: CONTEXT, accept: BETA_HEADER)
    end
  end
end
