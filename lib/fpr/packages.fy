require: "package"

require("connection_pool")

class FPR {
  class Packages {
    REDIS_POOL = ConnectionPool new(<['size => 10, 'timeout => 5]>) { Redis Client new }

    def with_redis: block {
      REDIS_POOL with_connection(&block)
    }

    def get_packages {
      with_redis: |r| {
        r get: 'package_list . to_a
      }
    }
  }
}