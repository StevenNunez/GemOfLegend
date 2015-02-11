VCR.config do |config|
  config.cassette_library_dir = "fixtures/cassettes"
  config.stub_with :webmock
  config.filter_sensitive_data("LOL_KEY") { ENV.fetch("LOL_API_KEY") }
end
