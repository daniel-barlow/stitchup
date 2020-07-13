require "stitchup/result"
require "stitchup/source"
require "stitchup/field"

module Stitchup
  class Template
    def self.parse(source:, fields:)
      index = 1
      fields = fields.reduce(Result.unit([])) { |m, (fieldname, subst)|
        m << Field.parse(name: fieldname, value: subst)
      }
      Result.unit
        .assoc(:source, Source.parse(source))
        .assoc(:fields, fields)
        .lift { |v| Template.new(v) }
    end

    attr_reader :source, :fields

    private

    def initialize(source:, fields:)
      @source = source
      @fields = fields
    end
  end
end
