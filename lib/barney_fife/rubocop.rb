# Run PRs through Rubocop Filter
# Process overview:
# - Receive PR hook (http://developer.github.com/v3/activity/events/types/#pullrequestevent)
# - When PR hook is opened/synchronize/re-opened, continue
# - Find out which files were changed (http://developer.github.com/v3/pulls/#list-pull-requests-files)
# -- Any file in json response Array 'added' or 'modified'?
# -- api.github.com/repos/:owner/:repo/pulls/:number/files
# -- 'https://api.github.com/repos/primedia/ag/pulls/100/files' ?
# - Mktmpdir and download all files into there
# - Run rubocop on that dir/those files
# `rubocop --format progress --format json --out rubocop.json`
# - Clear out mktmpdir if it's not called in block form
# cli = Rubocop::CLI.new
# cli.run
#
# Get file via API
# https://stackoverflow.com/questions/17808702/smartest-way-to-grab-a-file-from-github-via-rest-api-or-ocktokit-ruby
# require 'octokit'
# require 'base64'
#
# api_response = Octokit.contents 'neilslater/games_dice',
#   :ref => 'v0.0.1', :path => 'README.md'
#   text_contents = Base64.decode64( api_response.content )
#   File.open( 'README.md', 'wb' ) { |file| file.puts text_contents }
#
# Didn't seem to work as well as straight api calls... maybe it will be easier at scale?

# Basic command
# `rubocop --format progress --out rubocop.progress --format json --out rubocop.json`

module BarneyFife
  module Rubocop
    RUBOCOP_CMD = 'rubocop'

    def self.run(pull_request_number: pr_number, owner: owner, repo: repo)
      Dir.mktmpdir('rubocop') do |tmpdir|
        RoundUp.call(pr_number, owner, repo, tmpdir)
        fuzz = Investigation.call(tmpdir)
        InvestigationPresenter.new(fuzz)
      end
    end
  end
end

