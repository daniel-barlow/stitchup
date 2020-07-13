module Stitchup
  class Result
    # Result is not intended to be instantiated directly: it's
    # a union type of Result::Success and Result::Failure

    def self.unit(value)
      Result::Success.new(value)
    end

    def self.fail(failure)
      Result::Failure.new(failure)
    end

    class Success < Result
      attr_reader :value

      def initialize(value = {})
        @value = value
      end

      def successful?
        true
      end

      def lift(&blk)
        # The block is called with the unwrapped internal value of the
        # result, and whatever it returns is assigned to that value.
        self.class.new(blk.call(@value))
      end

      def assoc(key, other)
        if other.successful?
          self.class.new(value.merge(key => other.value))
        else
          Failure.new(key => other.failure)
        end
      end
    end

    class Failure < Result
      attr_reader :failure

      def initialize(failure)
        @failure = failure
      end

      def successful?
        false
      end

      def lift(&blk)
        self
      end

      def assoc(key, other)
        if other.successful?
          self
        else
          self.class.new(failure.merge(key => other.failure))
        end
      end
    end
  end
end
