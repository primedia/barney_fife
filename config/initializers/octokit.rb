module GitHub
  Client = Octokit::Client.new(access_token: Rails.configuration.github_token)
end
