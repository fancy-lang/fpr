class FPR

require: "sinatra.fy"

require: "fpr/json"
require: "fpr/api_helpers"

class FPR {
  def self run_with_config: conf {
    configure: 'production with: { disable: 'show_errors }
    configure: ['production, 'development] with: {
      enable: 'logging
    }

    set: 'port to: $ *config*['port]
    set: 'server to: "puma"

    require: "fpr/http_api"
  }
}