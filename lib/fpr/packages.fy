require: "package"

require("connection_pool")
require("open-uri")
require("base64")

class FPR {
  class Packages {
    REDIS_POOL = ConnectionPool new(<['size => 10, 'timeout => 5]>) { Redis Client new }

    def with_redis: block {
      call_block = {
        block call: [*redis*]
      }

      if: *redis* then: call_block else: {
        REDIS_POOL with_connection() |c| {
          let: '*redis* be: c in: call_block
        }
      }
    }

    def key: package_name version: version ('latest) {
      if: (version == 'latest) then: {
        with_redis: {
          *redis* keys: "package:#{package_name}:*" . sort . last || ""
        }
      } else: {
        "package:#{package_name}:#{version}"
      }
    }

    ##########

    def packages {
      with_redis: {
        package_names . map: |name| {
          keys = *redis* keys: "package:#{name}:*" . map: |key| {
            Package from_json: $ *redis* get: key
          } . compact
        } . flatten
      }
    }

    def package_names {
      with_redis: @{ smembers: 'package_names }
    }

    def package: package_name version: version ('latest) {
      with_redis: {
        json = *redis* get: $ key: package_name version: version
        Package from_json: json
      }
    }

    def search_package: query {
      regexp = Regexp new(query)
      with_redis: {
        package_names select: @{ =~ regexp }
      }
    }

    def add_package: package_name {
      repo_user, repo_name = package_name split: "/"
      fancypack_url = "https://api.github.com/repos/#{package_name}/contents/#{repo_name}.fancypack"

      json = JSON load: $ open(fancypack_url)

      if: (json["message"] == "Not found") then: {
        return nil
      }

      content = Base64 decode64(json["content"])
      spec = content eval
      package = Package new: @{
        name: $ spec package_name
        version: $ spec version
        description: $ spec description
        dependencies: $ spec dependencies
        ruby_dependencies: $ spec ruby_dependencies
        repo_url: "https://github.com/#{package_name}"
        author: $ spec author
        email: $ spec email
      }

      with_redis: {
        *redis* sadd: ('package_names, "#{package_name}")
        *redis* set: ("package:#{package_name}:#{package version}", package for_json to_json)
      }

      package
    }
  }
}