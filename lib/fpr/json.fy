require("json")

class Object {
  def for_json {
    self
  }

  def to_json {
    for_json to_json()
  }
}

class Block {
  def for_json {
    to_hash_deep for_json
  }
}

class Array {
  def for_json {
    map: @{ for_json }
  }
}

class Hash {
  def for_json {
    map: |k v| {
      (k, v for_json)
    } . to_hash
  }
}

JSON metaclass alias_method: 'parse: for_ruby: 'parse
JSON metaclass alias_method: 'load: for_ruby: 'load
JSON metaclass alias_method: 'dump: for_ruby: 'dump
