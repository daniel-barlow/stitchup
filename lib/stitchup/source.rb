require "stitchup/result"
require "uri"

module Stitchup
  class Source
    def self.parse(url_string)
      uri = URI.parse(url_string)
      if uri.is_a? URI::HTTP
        Result::Success.new.unit(uri)
      else
        Result::Failure.new.fail("#{url_string} is not HTTP(S)")
      end
    end

    private

    def initialize(url)
      @url = url
    end
  end
end
