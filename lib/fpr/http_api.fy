get: "/" do: {
  with_json_response: {
    {
      packages: [
        {
          name: "test"
          version: "1.2.0"
          description: "hello, world!"
          dependencies: [1,2,3]
        }
      ]
    }
  }
}