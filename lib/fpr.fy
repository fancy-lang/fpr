class FPR

require: "sinatra.fy"
require: "redis.fy"

require: "fpr/json"
require: "fpr/api_helpers"
require: "fpr/package"
require: "fpr/packages"

class FPR {
  def self run_with_config: conf {
    configure: 'production with: { disable: 'show_errors }
    configure: ['production, 'development] with: {
      enable: 'logging
    }

    set: 'port to: $ conf['port]
    set: 'server to: "puma"

    require: "fpr/http_api"
  }
}