class Fancy Package Dependency {
  def self from_json: json {
    if: json then: {
      new from_json: $ JSON parse: json
    }
  }


  def for_json {
    @{
      name: @name
      version: @version
    }
  }

  def from_json: json {
    @name, @version = json values_at: ("name", "version")
    self
  }
}

class Fancy Package RubyDependency {
  def self from_json: json {
    if: json then: {
      new from_json: $ JSON parse: json
    }
  }


  def for_json {
    @{
      gem_name: @gem_name
      version: @version
    }
  }

  def from_json: json {
    @gem_name, @version = json values_at: ("gem_name", "version")
    self
  }
}
