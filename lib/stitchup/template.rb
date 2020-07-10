require 'stitchup/result'
require 'stitchup/source'
require 'stitchup/field'

module Stitchup
  class Template
    def self.parse(source:, fields:)
      index = 1
      fields = fields.reduce(Result::Success.new) { |m, (fieldname, subst)|
        # the Result is a key->value data structure but we'd rather
        # have an array here.  Faking it while I think about how to do it
        key = "f#{index+=1}"
        m.assoc(key, Field.parse(name: fieldname, value: subst))
      }
      Result::Success.new
        .assoc(:source, Source.parse(source))
        .assoc(:fields, fields)
        .lift {|v| Template.new(v)}
    end

    attr_reader :source, :fields

    private

    def initialize(source:, fields:)
      @source = source
      @fields = fields
    end
  end
end
