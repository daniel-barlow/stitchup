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

    def unit(value)
      # XXX should we check for failure before doing this? Not
      # sure. So far I haven't had to use it except on a brand-new
      # instance so the question hasn't arisen
      @value = value
      self
    end

    def lift(&blk)
      # The block is called with the unwrapped internal value of the
      # result, and whatever it returns is assigned to that value.
      # Possibly we should be creating a new instance of the result
      # instead of mutating self
      @value = blk.call(@value) if successful?
      self
    end

    class Success < Result
      attr_reader :value

      def initialize(value = {})
        @value = value
      end

      def successful?
        true
      end

      def assoc(key, other, &blk)
        if other.successful?
          self.class.new(value.merge(key => other.value))
        else
          Failure.new(key => other.failure)
        end
      end
    end

    class Failure < Result
      attr_reader :failure

      def successful?
        false
      end

      def initialize(failure)
        @failure = failure
      end

      def assoc(key, other, &blk)
        if other.successful?
          self
        else
          self.class.new(failure.merge(key => other.failure))
        end
      end
    end
  end
end
