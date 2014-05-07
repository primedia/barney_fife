require 'json'
require 'open3'
require 'tempfile'
require 'base64'

# external gems
require 'pmap'
require 'hashie'
require 'dotenv'
require 'faraday'
require 'faraday_middleware'
require 'octokit'

Dotenv.load!

module BarneyFife
  module Coffeelint

    def self.run(opts = {})
      # Usage: presenter = BarneyFife::Coffeelint.run(issue_number: '820', owner: 'primedia', repo: 'ag')
      issue_number = opts.fetch(:issue_number) { '820' }
      owner = opts.fetch(:owner) { 'primedia' }
      repo = opts.fetch(:repo) { 'ag' }
      Dir.mktmpdir('coffeelint') do |tmpdir|
        RoundUp.call(issue_number, owner, repo, tmpdir)
        command = "coffeelint -f lib/coffeelint/config.json #{tmpdir}/app/assets/javascripts"
        fuzz = Investigation.call(command, tmpdir)
        presenter = InvestigationPresenter.new(fuzz)
      end
    end
  end
end

