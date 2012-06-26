class Fancy Package Specification {
  def initialize: block {
    @include_files = []
    @bin_files = []
    @dependencies = []
    @ruby_dependencies = []

    block call: [self]
  }

  def self from_json: json {
    if: json then: {
      new from_json: $ JSON parse: json
    }
  }

  def for_json {
    @{
      author: @author
      email: @email
      include_files: @include_files
      bin_files: @bin_files
      description: @description
      homepage: @homepage
      version: @version
      gh_user: @gh_user
      package_name: @package_name
      dependencies: $ @dependencies map: @{ for_json }
      ruby_dependencies: $ @ruby_dependencies map: @{ for_json }
    }
  }

  def from_json: json {
    @author, @email, @include_files, @bin_files, \
    @description, @homepage, @version, @gh_user, \
    @package_name, @dependencies, @ruby_dependencies = \
      json values_at: ("author", "email", "include_files", "bin_files", \
                       "description", "homepage", "version", "gh_user", \
                       "package_name", "dependencies", "ruby_dependencies")

    @include_files = @include_files to_a
    @bin_files = @bin_files to_a
    @dependencies = @dependencies to_a
    @ruby_dependencies = @ruby_dependencies to_a
    self
  }

  def repo_url {
    "https://github.com/#{@gh_user}/#{@package_name}"
  }
}