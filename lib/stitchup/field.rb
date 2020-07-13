require "stitchup/result"

module Stitchup
  class Field
    def self.parse(name:, value:)
      if value.is_a? String
        Result::Success.new
          .assoc(:name, Result::Success.new(name))
          .assoc(:value, Result::Success.new(value))
          .lift { |v| Field.new(v) }
      else
        Result.fail({name: name, message: "value is not a string"})
      end
    end

    private

    def initialize(name:, value:)
      @name = name
      @value = value
    end
  end
end
