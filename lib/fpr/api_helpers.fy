def with_json_response: block {
  content_type("json")
  response = nil
  try {
    response = block call: [FPR Packages new]
  } catch StandardError => e {
    *stderr* println: "ERROR: #{e}"
    response = { error: "API Error." }
  } finally {
    return response to_json
  }
}