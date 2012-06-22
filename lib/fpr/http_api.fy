get: "/" do: {
  with_json_response: |p| {
    {
      packages: $ p get_packages
    }
  }
}