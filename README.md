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

``` javascript
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
```

### POST via Curl command 
Content type set to JSON, using actual github webhook data to the route we use for rubocop

```
curl -X POST -H "Content-Type: application/json" -d "$(cat curl_cmd)" http://localhost:3000/webhooks/rubocop
```

``` json
{
  "metadata": {
    "rubocop_version": "0.18.1",
    "ruby_engine": "ruby",
    "ruby_version": "2.1.1",
    "ruby_patchlevel": "76",
    "ruby_platform": "x86_64-darwin13.0"
  },
  "files": [
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/image_path_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/mgtcologo_reader.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/multi_cat_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 10,
            "column": 40
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/office_hours_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body beginning.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 4,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/overall_ratings_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 11,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/pet_policies_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/accessors/to_arry_writer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 3
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/bridge/base.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [97/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Missing top-level module documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 10,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 16,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 18,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [97/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 21,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Use empty lines between defs.",
          "cop_name": "EmptyLineBetweenDefs",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Align the parameters of a method call if they span more than one line.",
          "cop_name": "AlignParameters",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Align the parameters of a method call if they span more than one line.",
          "cop_name": "AlignParameters",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 51,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 53,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [94/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [105/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 70,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [105/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 71,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Align the parameters of a method call if they span more than one line.",
          "cop_name": "AlignParameters",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 9
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 91,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 97,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [100/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 99,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 101,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [87/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [96/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 104,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Align the parameters of a method call if they span more than one line.",
          "cop_name": "AlignParameters",
          "corrected": null,
          "location": {
            "line": 106,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 111,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 113,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 117,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 123,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 125,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 126,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 128,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 129,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 130,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 137,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 138,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 143,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 145,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 146,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 147,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [124/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 150,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 159,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [101/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 161,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 166,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 168,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [103/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 170,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [109/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 175,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [103/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 180,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Extra blank line detected.",
          "cop_name": "EmptyLines",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [101/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 193,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 194,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 199,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 203,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [102/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 213,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 214,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 219,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [110/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 220,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [109/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 225,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 226,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 231,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 232,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 233,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 234,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 235,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 236,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 237,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 238,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 240,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [81/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 242,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 248,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 255,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 257,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 258,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 259,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 261,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 262,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [87/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 263,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 269,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 275,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 280,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 281,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 282,
            "column": 63
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 284,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 285,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 288,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 289,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 290,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 292,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [87/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 293,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 299,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [112/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 300,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [94/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 306,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 307,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [87/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 311,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 316,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 318,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 336,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 337,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 342,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 343,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 344,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 345,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 346,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 347,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [95/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 350,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 351,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 356,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 358,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 363,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 364,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [96/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 370,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 371,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 376,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 377,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [103/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 382,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 383,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 388,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [95/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 389,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 394,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 395,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 396,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 400,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 401,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 404,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 405,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 406,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 411,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 412,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 413,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 418,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 419,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 420,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 422,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 423,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 424,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 425,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [87/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 426,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 427,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 428,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 429,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [124/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 436,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 440,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Use def with parentheses when there are parameters.",
          "cop_name": "MethodDefParentheses",
          "corrected": null,
          "location": {
            "line": 448,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [108/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 455,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 459,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 459,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 460,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 460,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 461,
            "column": 52
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 461,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 461,
            "column": 67
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 461,
            "column": 76
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 472,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [16/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 474,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 495,
            "column": 58
          }
        },
        {
          "severity": "convention",
          "message": "Missing space after #.",
          "cop_name": "LeadingCommentSpace",
          "corrected": null,
          "location": {
            "line": 514,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 514,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 516,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 538,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Space missing to the left of {.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 538,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 538,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 538,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 538,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 544,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 546,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/bridge/detailed.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Class definition is too long. [211/100]",
          "cop_name": "ClassLength",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [19/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 10,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 16,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 23,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 25,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 27,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 28,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 29,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Space missing to the left of {.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 71
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [105/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer map over collect.",
          "cop_name": "CollectionMethods",
          "corrected": null,
          "location": {
            "line": 50,
            "column": 58
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Extra blank line detected.",
          "cop_name": "EmptyLines",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 1
          }
        },
        {
          "severity": "warning",
          "message": "Useless assignment to variable - spotlight_text",
          "cop_name": "UselessAssignment",
          "corrected": null,
          "location": {
            "line": 111,
            "column": 13
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 111,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 43
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [12/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 117,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 125,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 134,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 134,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 134,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Favor modifier unless usage when you have a single-line body. Another good alternative is the usage of control flow \u0026\u0026/||.",
          "cop_name": "IfUnlessModifier",
          "corrected": null,
          "location": {
            "line": 138,
            "column": 9
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 152,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 152,
            "column": 56
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 152,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 152,
            "column": 86
          }
        },
        {
          "severity": "convention",
          "message": "Prefer *each* over *for*.",
          "cop_name": "For",
          "corrected": null,
          "location": {
            "line": 155,
            "column": 9
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 163,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 163,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 163,
            "column": 61
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_livechat to livechat?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 170,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_coords to coords?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 174,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_follow_links to follow_links?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 178,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_verizon to verizon?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 182,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 191,
            "column": 23
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 191,
            "column": 25
          }
        },
        {
          "severity": "convention",
          "message": "Use alias_method instead of alias.",
          "cop_name": "Alias",
          "corrected": null,
          "location": {
            "line": 193,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [29/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 195,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 268,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/mobile/base.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [84/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [1182/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [1122/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body beginning.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Missing top-level module documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 74,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 76,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 78,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 82,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 95,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 100,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 101,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Use alias_method instead of alias.",
          "cop_name": "Alias",
          "corrected": null,
          "location": {
            "line": 108,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_hdfloorplans to hdfloorplans?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 110,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_hdtour to hdtour?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_hdphotos to hdphotos?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 118,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Rename has_hdvideo to hdvideo?.",
          "cop_name": "PredicateName",
          "corrected": null,
          "location": {
            "line": 122,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 155,
            "column": 42
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [96/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 160,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [109/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 169,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 180,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 181,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 185,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 198,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 202,
            "column": 9
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 206,
            "column": 26
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [13/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 215,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [109/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 222,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 229,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 236,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 236,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 236,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 238,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Use string literal '' instead of String.new.",
          "cop_name": "EmptyLiteral",
          "corrected": null,
          "location": {
            "line": 246,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Use \u0026\u0026 instead of and.",
          "cop_name": "AndOr",
          "corrected": null,
          "location": {
            "line": 251,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Separate every 3 digits in the integer portion of a number with underscores(_).",
          "cop_name": "NumericLiterals",
          "corrected": null,
          "location": {
            "line": 251,
            "column": 32
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 253,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 255,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/models/listing/mobile/detailed.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Extra empty line detected at body beginning.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Class definition is too long. [124/100]",
          "cop_name": "ClassLength",
          "corrected": null,
          "location": {
            "line": 4,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 4,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 21,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [81/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 35,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '\u0026\u0026'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [15/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 47,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [104/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [15/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 83,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Prefer map over collect.",
          "cop_name": "CollectionMethods",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Cyclomatic complexity for pet_policies is too high. [8/6]",
          "cop_name": "CyclomaticComplexity",
          "corrected": null,
          "location": {
            "line": 109,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [136/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 113,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 33
          }
        },
        {
          "severity": "convention",
          "message": "Space missing to the left of {.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 33
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=='.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 42
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Prefer map over collect.",
          "cop_name": "CollectionMethods",
          "corrected": null,
          "location": {
            "line": 128,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 134,
            "column": 25
          }
        },
        {
          "severity": "convention",
          "message": "Inconsistent indentation detected.",
          "cop_name": "IndentationConsistency",
          "corrected": null,
          "location": {
            "line": 137,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Inconsistent indentation detected.",
          "cop_name": "IndentationConsistency",
          "corrected": null,
          "location": {
            "line": 138,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Avoid the use of Perl-style backrefs.",
          "cop_name": "PerlBackrefs",
          "corrected": null,
          "location": {
            "line": 138,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Avoid the use of Perl-style backrefs.",
          "cop_name": "PerlBackrefs",
          "corrected": null,
          "location": {
            "line": 140,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 145,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 147,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/app/presenters/formatters.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level module documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 33
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [98/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [98/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 12,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Method has too many lines. [13/10]",
          "cop_name": "MethodLength",
          "corrected": null,
          "location": {
            "line": 35,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 47,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Use \u0026\u0026 instead of and.",
          "cop_name": "AndOr",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 15
          }
        },
        {
          "severity": "convention",
          "message": "Separate every 3 digits in the integer portion of a number with underscores(_).",
          "cop_name": "NumericLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer map over collect.",
          "cop_name": "CollectionMethods",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 60
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 67
          }
        },
        {
          "severity": "convention",
          "message": "Space missing to the left of {.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 67
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [121/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 84
          }
        },
        {
          "severity": "convention",
          "message": "Prefer map over collect.",
          "cop_name": "CollectionMethods",
          "corrected": null,
          "location": {
            "line": 73,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [110/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 76,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/config/endeca_string_definitions.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [128/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [119/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 5,
            "column": 80
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/lib/endeca_string.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body beginning.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 3,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 4,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Use `fail` instead of `raise` to signal exceptions.",
          "cop_name": "SignalException",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Redundant `self` detected.",
          "cop_name": "RedundantSelf",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Favor modifier if usage when you have a single-line body. Another good alternative is the usage of control flow \u0026\u0026/||.",
          "cop_name": "IfUnlessModifier",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 7
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Name `reduce` block params |a, e|.",
          "cop_name": "SingleLineBlockParams",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 41
          }
        },
        {
          "severity": "convention",
          "message": "Do not use semicolons to terminate expressions.",
          "cop_name": "Semicolon",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Replace class var @@definitions with a class instance var.",
          "cop_name": "ClassVars",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 5
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 66,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/lib/modules/string_transformer.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level module documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 1,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body beginning.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 2,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 11,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Extra empty line detected at body end.",
          "cop_name": "EmptyLinesAroundBody",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 1
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/lib/endeca_string_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after colon.",
          "cop_name": "SpaceAfterColon",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 69
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [98/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 12,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 18,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [97/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 27,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 34,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 35,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 35,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 39,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 50
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 53,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 53,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 72
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [95/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 89
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 85
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 85
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 85
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 40
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 69
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 47
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 78
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 85
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [116/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 100
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 107
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 115
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 71,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 75,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 76,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 52
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 63
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 71
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 87,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Use %w or %W for array of words.",
          "cop_name": "WordArray",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 59
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 60
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 91,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Use %w or %W for array of words.",
          "cop_name": "WordArray",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 43
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Use %w or %W for array of words.",
          "cop_name": "WordArray",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 63
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 64
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 69
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 95,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 99,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 105,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 111,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 114,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 11
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 21
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 119,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 120,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 52
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 63
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 71
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [92/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 121,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 129,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [97/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 132,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 137,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 138,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [126/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 107
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 124
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 142,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 143,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [126/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 107
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 144,
            "column": 124
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 147,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 148,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [126/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 107
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 149,
            "column": 124
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 152,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 153,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 154,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 154,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [123/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 154,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 154,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 154,
            "column": 104
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 157,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 158,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [98/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 159,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 164,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 170,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [120/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 85
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 101
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 176,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 177,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 178,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [93/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 178,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 181,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 182,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [113/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 80
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/lib/modules/string_transformer_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 21,
            "column": 45
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/models/listing/bridge/base_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 10,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 12,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 18,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 36,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [155/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 44,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 48,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 53,
            "column": 56
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 57,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [182/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 66,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 66,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 69,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 69,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 70,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 70,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 71,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 71,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 78,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [309/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 78,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 81,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 81,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 81,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 82,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 82,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 82,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 83,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 83,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 83,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 86,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 86,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Extra blank line detected.",
          "cop_name": "EmptyLines",
          "corrected": null,
          "location": {
            "line": 91,
            "column": 1
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 94,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [246/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 97,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [268/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 97,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 103,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 107,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 111,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [96/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 112,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 115,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 116,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [121/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 116,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 119,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 124,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 131,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 133,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [246/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 133,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 139,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 145,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 147,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [246/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 147,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 153,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 157,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 158,
            "column": 61
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [143/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 158,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 163,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 165,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 166,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 166,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [137/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 166,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 167,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [141/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 167,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 170,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 171,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 172,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 172,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 175,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 176,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 176,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 177,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 177,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 180,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 181,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 182,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 182,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 185,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 38
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 186,
            "column": 48
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 187,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 187,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 190,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space inside empty hash literal braces detected.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 191,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 192,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 192,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 197,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 199,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [120/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 199,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 205,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 206,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 206,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [166/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 206,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 206,
            "column": 115
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 211,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 213,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [120/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 213,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 219,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [170/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 220,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 223,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 224,
            "column": 56
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 224,
            "column": 58
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 224,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [187/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 224,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 224,
            "column": 136
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 229,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 231,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [324/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 231,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 235,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 239,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 244,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 246,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [385/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 246,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 250,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 254,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 259,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 260,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 261,
            "column": 28
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 262,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 265,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 266,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 267,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 271,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 275,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 276,
            "column": 71
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [94/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 276,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 280,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 281,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 281,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 281,
            "column": 51
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 281,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 282,
            "column": 61
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 285,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 59
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 82
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 286,
            "column": 89
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 287,
            "column": 23
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 288,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 291,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 292,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 292,
            "column": 32
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 292,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 292,
            "column": 62
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 293,
            "column": 62
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 296,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 297,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 297,
            "column": 31
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 297,
            "column": 41
          }
        },
        {
          "severity": "convention",
          "message": "Use %w or %W for array of words.",
          "cop_name": "WordArray",
          "corrected": null,
          "location": {
            "line": 298,
            "column": 76
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 298,
            "column": 77
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 298,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space missing after comma.",
          "cop_name": "SpaceAfterComma",
          "corrected": null,
          "location": {
            "line": 298,
            "column": 82
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 298,
            "column": 83
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 301,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 302,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 302,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 302,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 302,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 24
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 44
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 55
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [100/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 303,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 304,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 307,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 308,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 308,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 308,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 308,
            "column": 106
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 24
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 56
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 81
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 309,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 310,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 313,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 314,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 314,
            "column": 15
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 314,
            "column": 26
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 314,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 318,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 320,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 32
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [118/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 322,
            "column": 118
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 326,
            "column": 10
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 330,
            "column": 10
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 331,
            "column": 51
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [114/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 331,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 336,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 342,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 346,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 351,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 352,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 352,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 353,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 356,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 357,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 357,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [88/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 358,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 361,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 362,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 362,
            "column": 37
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 363,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 366,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 370,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 370,
            "column": 46
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 374,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 387,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 389,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 390,
            "column": 34
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [156/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 390,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 396,
            "column": 10
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 398,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 398,
            "column": 47
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [102/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 398,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 399,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 399,
            "column": 49
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [105/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 399,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 405,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 412,
            "column": 10
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/models/listing/bridge/basic_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 9,
            "column": 61
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 12,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 86
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [116/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 27
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 28,
            "column": 27
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 34,
            "column": 27
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 20
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 36
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 45,
            "column": 8
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/models/listing/mobile/base_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Missing top-level class documentation comment.",
          "cop_name": "Documentation",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 3
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 11,
            "column": 6
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 11,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 16,
            "column": 78
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 16,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [90/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 20,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 20,
            "column": 86
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 25,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 72
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [132/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [113/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 102
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 36,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 65
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [103/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 45,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 66
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [102/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 50,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 51,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 69
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 52,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 55,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 69
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 61,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 32
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [80/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 62,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [83/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space between { and | missing.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 16
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '+'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 29
          }
        },
        {
          "severity": "convention",
          "message": "Space missing inside }.",
          "cop_name": "SpaceAroundBlockBraces",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 47
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 73,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [98/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 74,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 77,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 78,
            "column": 70
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 82,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 87,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 94,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 94,
            "column": 92
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 95,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 95,
            "column": 92
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [99/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 96,
            "column": 92
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 100,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 25
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 25
          }
        },
        {
          "severity": "convention",
          "message": "Redundant curly braces around a hash parameter.",
          "cop_name": "BracesAroundHashParameters",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [95/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 90
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 102,
            "column": 92
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 103,
            "column": 74
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [82/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 103,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 106,
            "column": 8
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/models/listing/mobile/detailed_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 5,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 6,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [277/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 170
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 190
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 205
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 219
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 232
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 245
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 7,
            "column": 253
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 11,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 12,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 57
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [392/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 233
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 252
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 265
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 290
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 308
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 318
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 334
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 359
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 13,
            "column": 378
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 17,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 18,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 58
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [145/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 97
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 98
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 19,
            "column": 127
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 23,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 24,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 29,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 31,
            "column": 30
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 75
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [149/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 83
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 139
          }
        },
        {
          "severity": "convention",
          "message": "Space inside square brackets detected.",
          "cop_name": "SpaceInsideBrackets",
          "corrected": null,
          "location": {
            "line": 32,
            "column": 148
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 35,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 40,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [91/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 90
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 45,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 76
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 77
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [179/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 82
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 84
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 89
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 94
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 96
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 101
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 106
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 113
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 119
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 121
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 134
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 139
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 141
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 148
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 152
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 154
          }
        },
        {
          "severity": "convention",
          "message": "Use the new Ruby 1.9 hash syntax.",
          "cop_name": "HashSyntax",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 158
          }
        },
        {
          "severity": "convention",
          "message": "Surrounding space missing for operator '=\u003E'.",
          "cop_name": "SpaceAroundOperators",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 173
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 178
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 49,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [100/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 56,
            "column": 99
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [143/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 88
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 93
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 120
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 136
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 73,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 75,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 78,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 74
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [81/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 85,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 87,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 22
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [89/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 87
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 92,
            "column": 10
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 100,
            "column": 14
          }
        },
        {
          "severity": "convention",
          "message": "Space inside { missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 101,
            "column": 22
          }
        },
        {
          "severity": "convention",
          "message": "Space inside } missing.",
          "cop_name": "SpaceInsideHashLiteralBraces",
          "corrected": null,
          "location": {
            "line": 101,
            "column": 45
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 105,
            "column": 10
          }
        }
      ]
    },
    {
      "path": "../../../tmp/rubocop20140505-59173-1vgtdxv/spec/presenters/formatters_spec.rb",
      "offences": [
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 32
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [185/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 8,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 15
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 35
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 53
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [142/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 86
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 100
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 14,
            "column": 121
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 19
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 39
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 61
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 76
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [150/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 94
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 108
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 15,
            "column": 129
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 20,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 21,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 67
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 22,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 25,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [107/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 26,
            "column": 90
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 29,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 67
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [85/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 30,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 33,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 34,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 34,
            "column": 68
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [86/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 34,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 37,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 38,
            "column": 54
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 41,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 42,
            "column": 55
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 45,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [184/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 46,
            "column": 117
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 49,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 50,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [152/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 50,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 50,
            "column": 92
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 53,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 18
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [133/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 54,
            "column": 91
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 58,
            "column": 12
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 59,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [121/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 60,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 63,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [121/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 64,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 67,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [122/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 68,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 71,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [105/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 72,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 75,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 76,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [106/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 76,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 79,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [220/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 80,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 83,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [188/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 84,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 87,
            "column": 8
          }
        },
        {
          "severity": "convention",
          "message": "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "cop_name": "StringLiterals",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 17
          }
        },
        {
          "severity": "convention",
          "message": "Line is too long. [169/79]",
          "cop_name": "LineLength",
          "corrected": null,
          "location": {
            "line": 88,
            "column": 80
          }
        },
        {
          "severity": "convention",
          "message": "1 trailing blank lines detected.",
          "cop_name": "TrailingBlankLines",
          "corrected": null,
          "location": {
            "line": 93,
            "column": 1
          }
        }
      ]
    }
  ],
  "summary": {
    "offence_count": 1114,
    "target_file_count": 22,
    "inspected_file_count": 22
  }
}
```

### Using Postman API requests
```
POST /webhooks/rubocop HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cache-Control: no-cache

{ "payload": {"action": "reopened", "number": 820, "pull_request": { "url": "https://api.github.com/repos/primedia/ag/pulls/1", "html_url": "https://github.com/primedia/ag/pull/1", "diff_url": "https://github.com/primedia/ag/pulls/1.diff", "patch_url": "https://github.com/primedia/ag/pulls/1.patch", "issue_url": "https://api.github.com/repos/primedia/ag/issues/1", "commits_url": "https://api.github.com/repos/primedia/ag/pulls/1/commits", "review_comments_url": "https://api.github.com/repos/primedia/ag/pulls/1/comments", "review_comment_url": "https://api.github.com/repos/primedia/ag/pulls/comments/{number}", "comments_url": "https://api.github.com/repos/primedia/ag/issues/1/comments", "statuses_url": "https://api.github.com/repos/primedia/ag/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e", "number": 1, "state": "open", "title": "new-feature", "body": "Please pull these awesome changes", "created_at": "2011-01-26T19:01:12Z", "updated_at": "2011-01-26T19:01:12Z", "closed_at": "2011-01-26T19:01:12Z", "merged_at": "2011-01-26T19:01:12Z", "head": { "label": "new-topic", "ref": "new-topic", "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e", "user": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "repo": { "id": 1296269, "owner": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "name": "ag", "full_name": "primedia/ag", "description": "This your first repo!", "private": false, "fork": false, "url": "https://api.github.com/repos/primedia/ag", "html_url": "https://github.com/primedia/ag", "clone_url": "https://github.com/primedia/ag.git", "git_url": "git://github.com/primedia/ag.git", "ssh_url": "git@github.com:primedia/ag.git", "svn_url": "https://svn.github.com/primedia/ag", "mirror_url": "git://git.example.com/primedia/ag", "homepage": "https://github.com", "language": null, "forks_count": 9, "stargazers_count": 80, "watchers_count": 80, "size": 108, "default_branch": "master", "master_branch": "master", "open_issues_count": 0, "pushed_at": "2011-01-26T19:06:43Z", "created_at": "2011-01-26T19:01:12Z", "updated_at": "2011-01-26T19:14:43Z" } }, "base": { "label": "master", "ref": "master", "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e", "user": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "repo": { "id": 1296269, "owner": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "name": "ag", "full_name": "primedia/ag", "description": "This your first repo!", "private": false, "fork": false, "url": "https://api.github.com/repos/primedia/ag", "html_url": "https://github.com/primedia/ag", "clone_url": "https://github.com/primedia/ag.git", "git_url": "git://github.com/primedia/ag.git", "ssh_url": "git@github.com:primedia/ag.git", "svn_url": "https://svn.github.com/primedia/ag", "mirror_url": "git://git.example.com/primedia/ag", "homepage": "https://github.com", "language": null, "forks_count": 9, "stargazers_count": 80, "watchers_count": 80, "size": 108, "default_branch": "master", "master_branch": "master", "open_issues_count": 0, "pushed_at": "2011-01-26T19:06:43Z", "created_at": "2011-01-26T19:01:12Z", "updated_at": "2011-01-26T19:14:43Z" } }, "_links": { "self": { "href": "https://api.github.com/repos/primedia/ag/pulls/1" }, "html": { "href": "https://github.com/primedia/ag/pull/1" }, "issue": { "href": "https://api.github.com/repos/primedia/ag/issues/1" }, "comments": { "href": "https://api.github.com/repos/primedia/ag/issues/1/comments" }, "review_comments": { "href": "https://api.github.com/repos/primedia/ag/pulls/1/comments" }, "review_comment": { "href": "https://api.github.com/repos/primedia/ag/pulls/comments/{number}" }, "commits": { "href": "https://api.github.com/repos/primedia/ag/pulls/1/commits" }, "statuses": { "href": "https://api.github.com/repos/primedia/ag/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e" } }, "user": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "merge_commit_sha": "e5bd3914e2e596debea16f433f57875b5b90bcd6", "merged": false, "mergeable": true, "merged_by": { "login": "primedia", "id": 1, "avatar_url": "https://github.com/images/error/primedia_happy.gif", "gravatar_id": "somehexcode", "url": "https://api.github.com/users/primedia", "html_url": "https://github.com/primedia", "followers_url": "https://api.github.com/users/primedia/followers", "following_url": "https://api.github.com/users/primedia/following{/other_user}", "gists_url": "https://api.github.com/users/primedia/gists{/gist_id}", "starred_url": "https://api.github.com/users/primedia/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/primedia/subscriptions", "organizations_url": "https://api.github.com/users/primedia/orgs", "repos_url": "https://api.github.com/users/primedia/repos", "events_url": "https://api.github.com/users/primedia/events{/privacy}", "received_events_url": "https://api.github.com/users/primedia/received_events", "type": "User", "site_admin": false }, "comments": 10, "commits": 3, "additions": 100, "deletions": 3, "changed_files": 5 }}} 
```

# TODO
- Investigate how to return API requests to post a comment on PR
    https://developer.github.com/guides/working-with-comments/
    - Create comment
    POST /repos/primedia/barney_fife/issues/1/comments -d {"body": "a new comment"}
- Investigate how to make linewise posts on PR
- Convert json 'offenses' into standard object that is easy to loop through and post comments
