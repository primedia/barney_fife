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

TODO:

- Post comments back to Github PR
  - Process: gather all comments from PR & prepare new line-wise comments.
  - Post new comments if current comment doesn't exist on same line w/ same body text, position, filename.
  - If a commit comment is out of date, the 'position' == null.
  - GET /repos/:owner/:repo/commits/:sha/comments


{ "payload": {"action": "reopened",
  "number": 820,
  "pull_request": {
                    "url": "https://api.github.com/repos/primedia/ag/pulls/1",
                    "html_url": "https://github.com/primedia/ag/pull/1",
                    "diff_url": "https://github.com/primedia/ag/pulls/1.diff",
                    "patch_url": "https://github.com/primedia/ag/pulls/1.patch",
                    "issue_url": "https://api.github.com/repos/primedia/ag/issues/1",
                    "commits_url": "https://api.github.com/repos/primedia/ag/pulls/1/commits",
                    "review_comments_url": "https://api.github.com/repos/primedia/ag/pulls/1/comments",
                    "review_comment_url": "https://api.github.com/repos/primedia/ag/pulls/comments/{number}",
                    "comments_url": "https://api.github.com/repos/primedia/ag/issues/1/comments",
                    "statuses_url": "https://api.github.com/repos/primedia/ag/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e",
                    "number": 1,
                    "state": "open",
                    "title": "new-feature",
                    "body": "Please pull these awesome changes",
                    "created_at": "2011-01-26T19:01:12Z",
                    "updated_at": "2011-01-26T19:01:12Z",
                    "closed_at": "2011-01-26T19:01:12Z",
                    "merged_at": "2011-01-26T19:01:12Z",
                    "head": {
                      "label": "new-topic",
                      "ref": "new-topic",
                      "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
                      "user": {
                        "login": "primedia",
                        "id": 1,
                        "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                        "gravatar_id": "somehexcode",
                        "url": "https://api.github.com/users/primedia",
                        "html_url": "https://github.com/primedia",
                        "followers_url": "https://api.github.com/users/primedia/followers",
                        "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                        "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                        "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                        "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                        "organizations_url": "https://api.github.com/users/primedia/orgs",
                        "repos_url": "https://api.github.com/users/primedia/repos",
                        "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                        "received_events_url": "https://api.github.com/users/primedia/received_events",
                        "type": "User",
                        "site_admin": false
                      },
                      "repo": {
                        "id": 1296269,
                        "owner": {
                          "login": "primedia",
                          "id": 1,
                          "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                          "gravatar_id": "somehexcode",
                          "url": "https://api.github.com/users/primedia",
                          "html_url": "https://github.com/primedia",
                          "followers_url": "https://api.github.com/users/primedia/followers",
                          "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                          "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                          "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                          "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                          "organizations_url": "https://api.github.com/users/primedia/orgs",
                          "repos_url": "https://api.github.com/users/primedia/repos",
                          "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                          "received_events_url": "https://api.github.com/users/primedia/received_events",
                          "type": "User",
                          "site_admin": false
                        },
                        "name": "ag",
                        "full_name": "primedia/ag",
                        "description": "This your first repo!",
                        "private": false,
                        "fork": false,
                        "url": "https://api.github.com/repos/primedia/ag",
                        "html_url": "https://github.com/primedia/ag",
                        "clone_url": "https://github.com/primedia/ag.git",
                        "git_url": "git://github.com/primedia/ag.git",
                        "ssh_url": "git@github.com:primedia/ag.git",
                        "svn_url": "https://svn.github.com/primedia/ag",
                        "mirror_url": "git://git.example.com/primedia/ag",
                        "homepage": "https://github.com",
                        "language": null,
                        "forks_count": 9,
                        "stargazers_count": 80,
                        "watchers_count": 80,
                        "size": 108,
                        "default_branch": "master",
                        "master_branch": "master",
                        "open_issues_count": 0,
                        "pushed_at": "2011-01-26T19:06:43Z",
                        "created_at": "2011-01-26T19:01:12Z",
                        "updated_at": "2011-01-26T19:14:43Z"
                      }
                    },
                    "base": {
                      "label": "master",
                      "ref": "master",
                      "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
                      "user": {
                        "login": "primedia",
                        "id": 1,
                        "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                        "gravatar_id": "somehexcode",
                        "url": "https://api.github.com/users/primedia",
                        "html_url": "https://github.com/primedia",
                        "followers_url": "https://api.github.com/users/primedia/followers",
                        "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                        "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                        "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                        "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                        "organizations_url": "https://api.github.com/users/primedia/orgs",
                        "repos_url": "https://api.github.com/users/primedia/repos",
                        "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                        "received_events_url": "https://api.github.com/users/primedia/received_events",
                        "type": "User",
                        "site_admin": false
                      },
                      "repo": {
                        "id": 1296269,
                        "owner": {
                          "login": "primedia",
                          "id": 1,
                          "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                          "gravatar_id": "somehexcode",
                          "url": "https://api.github.com/users/primedia",
                          "html_url": "https://github.com/primedia",
                          "followers_url": "https://api.github.com/users/primedia/followers",
                          "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                          "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                          "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                          "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                          "organizations_url": "https://api.github.com/users/primedia/orgs",
                          "repos_url": "https://api.github.com/users/primedia/repos",
                          "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                          "received_events_url": "https://api.github.com/users/primedia/received_events",
                          "type": "User",
                          "site_admin": false
                        },
                        "name": "ag",
                        "full_name": "primedia/ag",
                        "description": "This your first repo!",
                        "private": false,
                        "fork": false,
                        "url": "https://api.github.com/repos/primedia/ag",
                        "html_url": "https://github.com/primedia/ag",
                        "clone_url": "https://github.com/primedia/ag.git",
                        "git_url": "git://github.com/primedia/ag.git",
                        "ssh_url": "git@github.com:primedia/ag.git",
                        "svn_url": "https://svn.github.com/primedia/ag",
                        "mirror_url": "git://git.example.com/primedia/ag",
                        "homepage": "https://github.com",
                        "language": null,
                        "forks_count": 9,
                        "stargazers_count": 80,
                        "watchers_count": 80,
                        "size": 108,
                        "default_branch": "master",
                        "master_branch": "master",
                        "open_issues_count": 0,
                        "pushed_at": "2011-01-26T19:06:43Z",
                        "created_at": "2011-01-26T19:01:12Z",
                        "updated_at": "2011-01-26T19:14:43Z"
                      }
                    },
                    "_links": {
                      "self": {
                        "href": "https://api.github.com/repos/primedia/ag/pulls/1"
                      },
                      "html": {
                        "href": "https://github.com/primedia/ag/pull/1"
                      },
                      "issue": {
                        "href": "https://api.github.com/repos/primedia/ag/issues/1"
                      },
                      "comments": {
                        "href": "https://api.github.com/repos/primedia/ag/issues/1/comments"
                      },
                      "review_comments": {
                        "href": "https://api.github.com/repos/primedia/ag/pulls/1/comments"
                      },
                      "review_comment": {
                        "href": "https://api.github.com/repos/primedia/ag/pulls/comments/{number}"
                      },
                      "commits": {
                        "href": "https://api.github.com/repos/primedia/ag/pulls/1/commits"
                      },
                      "statuses": {
                        "href": "https://api.github.com/repos/primedia/ag/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e"
                      }
                    },
                    "user": {
                      "login": "primedia",
                      "id": 1,
                      "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                      "gravatar_id": "somehexcode",
                      "url": "https://api.github.com/users/primedia",
                      "html_url": "https://github.com/primedia",
                      "followers_url": "https://api.github.com/users/primedia/followers",
                      "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                      "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                      "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                      "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                      "organizations_url": "https://api.github.com/users/primedia/orgs",
                      "repos_url": "https://api.github.com/users/primedia/repos",
                      "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                      "received_events_url": "https://api.github.com/users/primedia/received_events",
                      "type": "User",
                      "site_admin": false
                    },
                    "merge_commit_sha": "e5bd3914e2e596debea16f433f57875b5b90bcd6",
                    "merged": false,
                    "mergeable": true,
                    "merged_by": {
                      "login": "primedia",
                      "id": 1,
                      "avatar_url": "https://github.com/images/error/primedia_happy.gif",
                      "gravatar_id": "somehexcode",
                      "url": "https://api.github.com/users/primedia",
                      "html_url": "https://github.com/primedia",
                      "followers_url": "https://api.github.com/users/primedia/followers",
                      "following_url": "https://api.github.com/users/primedia/following{/other_user}",
                      "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}",
                      "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}",
                      "subscriptions_url": "https://api.github.com/users/primedia/subscriptions",
                      "organizations_url": "https://api.github.com/users/primedia/orgs",
                      "repos_url": "https://api.github.com/users/primedia/repos",
                      "events_url": "https://api.github.com/users/primedia/events{/privacy}",
                      "received_events_url": "https://api.github.com/users/primedia/received_events",
                      "type": "User",
                      "site_admin": false
                    },
                    "comments": 10,
                    "commits": 3,
                    "additions": 100,
                    "deletions": 3,
                    "changed_files": 5
                  }}}
