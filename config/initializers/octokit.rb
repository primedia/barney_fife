if ENV['OCTOKIT_DEBUG']
  Octokit.middleware = Faraday::RackBuilder.new do |builder|
                        builder.response :logger
                        builder.use Octokit::Response::RaiseError
                        builder.adapter Faraday.default_adapter
                      end
end
module GitHub
  Client = Octokit::Client.new(access_token: Rails.configuration.github_token)
end
