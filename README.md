# Fancy Package Registry

FPR is Fancy's package registry (soon) residing online at
http://packages.fancy-lang.org

It's built with sinatra.fy, Fancy's Sinatra wrapper for lightweight
web development, and exposes a JSON API for searching, adding and
managing .fancypack Fancy packages.

## JSON API

### Package list

        GET /list
        # =>
        {
          "packages": [
            # packages each containing:
            {
              "name": name,
              "versions": [
                # versions, e.g.
                "1.2.3", "2.3.4", "3.0.0"
              ],
              "github_url": "user/repo",
              "author": {
                "name": "...",
                "email": "..."
              },
              "description": "....",
              "homepage": "http://...",
              # this list contains the dependencies of the latest version
              # for older dependency lists see
              # /info/<package>/<version> API method
              dependencies: [
                # ...
              ]
            }
          ]
        }


### Show package info

        GET /info/<package_name>[/<version>]
        # =>
        {
          "package": {
            "name": "...",
            "version": "...",
            "github_url": "user/repo",
            "author": {
              "name": "...",
              "email": "..."
            },
            "description": "...",
            "bin_files:" [
              # ...
            ],
            "include_files": [
              # ...
            ],
            "dependencies": [
              # ...
            ],
            "ruby_dependencies": [
              # ...
            ]
          }
        }


### Search package

        GET /search/<query>
        # =>
        {
          "found_packages": [
            {
              "name": "...",
              "versions": "...",
              "github_url": "user/repo",
              "description": "..."
            },
            # ...
          ]
        }


### More to come