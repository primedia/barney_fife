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

Wired into /webhooks/rubocop route via post request.

# TODO

- Post comments back to Github PR
  - Process: gather all comments from PR & prepare new line-wise comments.
  - Post new comments if current comment doesn't exist on same line w/ same body text, position, filename.
  - If a commit comment is out of date, the 'position' == null.
  - GET /repos/:owner/:repo/commits/:sha/comments
- Investigate how to return API requests to post a comment on PR
    https://developer.github.com/guides/working-with-comments/
    - Create comment
    POST /repos/primedia/barney_fife/issues/1/comments -d {"body": "a new comment"}
- Investigate how to make linewise posts on PR
- Convert json 'offenses' into standard object that is easy to loop through and post comments
