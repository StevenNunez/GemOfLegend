require 'spec_helper'

module GemOfLegend
  describe Client do
    context "without setting an api key" do
      it "raises error if LOL_API_Key isn't set" do
        stub_const('ENV', {})
        expect do
          GemOfLegend::Client.new(region: 'na')
        end.to raise_error("Set LOL_API_KEY environment variable")
      end
    end

    context "setting regions and api_key" do
      it "is successfully instantiated with valid regions" do
        valid_regions = ["br", "eune", "euw", "kr", "lan", "las", "na", "oce", "ru", "tr", "pbe"]
        valid_regions.each do |region|
          expect do
            GemOfLegend::Client.new(region: region)
          end.to_not raise_error
        end
      end

      it "throws an error if an invalid region is given" do
        expect do
          GemOfLegend::Client.new(region: 'mars')
        end.to raise_error(GemOfLegend::InvalidRegion)
      end

      it "knows its region" do
        client = GemOfLegend::Client.new(region: 'na')
        expect(client.region).to eq('na')
      end

      it "reads the API key from an environment variable" do
        allow(ENV).to receive(:fetch).with('LOL_API_KEY').and_return("My Key")
        client = GemOfLegend::Client.new(region: 'na')
        expect(client.api_key).to eq('My Key')
      end
    end

    context "Champions" do
      it "returns all of the champions" do
        client = GemOfLegend::Client.new(region: 'na')
        VCR.use_cassette('champions') do
          client.champions
        end
      end
    end
  end
end
