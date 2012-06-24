class FPR {
  class Package {

    def Package from_json: json {
      Package new from_json: $ JSON parse: json
    }

    read_write_slots: ('name, 'version, 'description, 'dependencies)
    def initialize: block {
      block call: [self]
    }

    def to_json {
      @{
        name: @name
        version: @version
        description: @description
        dependencies: @dependencies
      }
    }

    def from_json: json {
      @name, @version, @description, @dependencies = json values_at: ('name, 'version, 'description, 'dependencies)
      self
    }
  }
}