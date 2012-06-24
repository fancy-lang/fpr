get: "/" do: {
  with_json_response: |p| {
    {
      packages: $ p packages
    }
  }
}

get: "/info/:package_name/:version" do: |package_name, version| {
  with_json_response: |p| {
    {
      package: $ p package: package_name version: version . to_json
    }
  }
}