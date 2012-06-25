class FPR {
  class Package {

    def Package from_json: json {
      if: json then: {
        Package new from_json: $ JSON parse: json
      }
    }

    read_write_slots: ('repo_url, 'name, 'version, 'description, 'dependencies, 'ruby_dependencies, 'author, 'email)
    def initialize: block {
      @dependencies = []
      @ruby_dependencies = []
      block call: [self]
    }

    def for_json {
      @{
        name: @name
        version: @version
        description: @description
        dependencies: @dependencies
        ruby_dependencies: @ruby_dependencies
        repo_url: @repo_url
        author: @author
        email: @email
      }
    }

    def from_json: json {
      @name, @version, @description, @dependencies, @ruby_dependencies, @author, @email, @repo_url = json values_at: ("name", "version", "description", "dependencies", "ruby_dependencies", "author", "email", "repo_url")
      @dependencies = @dependencies to_a
      @ruby_dependencies = @ruby_dependencies to_a
      self
    }
  }
}