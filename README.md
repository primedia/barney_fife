# BarneyFife

Rails Api application that listens for Github webhook requests and then runs Rubocop on the files affected by that PR.

So far, the work has been done in lib/rubocop/runn r.rb.

To setup:

* Clone repo
* Bundle install
* `cp .env{.sample,}`
* Add Github Auth Token to `.env`
* Run `rake secret >> .env`
* Then edit `.env` to put secret token in correct spot.

To Run a Rubocop investigation:

`presenter = BarneyFife::Rubocop.run(issue_number: '820', owner: 'primedia', repo: 'ag')`

presenter has all the rubocop results.

NOT CURRENTLY WIRED INTO Rails app
