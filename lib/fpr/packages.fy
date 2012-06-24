require: "package"

require("connection_pool")

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

    def packages {
      with_redis: {
        package_names . map: |name| {
          json = *redis* get: $ key: name
          Package from_json: json
        }
      }
    }

    def package_names {
      with_redis: @{ get: 'package_names } to_a
    }

    def package: package_name version: version ('latest) {
      with_redis: {
        json = *redis* get: $ key: package_name version: version
        if: json then: {
          Package from_json: json
        }
      }
    }

    def key: package_name version: version ('latest) {
      "package:#{package_name}:#{version}"
    }
  }
}