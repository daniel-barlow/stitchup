require 'stitchup/result'

module Stitchup
  class Field
    def self.parse(name:, value:)
      if value.is_a? String
        Result::Success.new
          .assoc(:name, Result::Success.new.unit(name))
          .assoc(:value, Result::Success.new.unit(value))
          .lift {|v| Field.new(v)}
      else
        Result::Failure.new.fail({name: name, message: "value is not a string"})
      end
    end

    private

    def initialize(name:, value:)
      @name = name
      @value = value
    end
  end
end
