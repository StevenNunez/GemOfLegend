module GemOfLegend
  class InvalidRegion < StandardError; end
  class Client
    REGIONS = ["br", "eune", "euw", "kr", "lan", "las", "na", "oce", "ru", "tr", "pbe"]
    API_VERSION = "v1.2"
    URL_BASE = "https://na.api.pvp.net/api/lol"

    attr_reader :region, :api_key
    def initialize(region:)
      raise InvalidRegion unless REGIONS.include?(region)
      @api_key = ENV.fetch('LOL_API_KEY') { raise "Set LOL_API_KEY environment variable" }
      @region = region
    end

    def champions
     RestClient.get("#{endpoint}/champions")
    end

    def endpoint
      [URL_BASE, region, API_VERSION].join("/")
    end
  end
end
