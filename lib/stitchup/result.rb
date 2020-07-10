module Stitchup
  class Result
    attr_reader :value, :failure

    # Result is not intended to be instantiated directly: it's
    # supposed to be a union type of Result::Success and
    # Result::Failure. There is currently nothing in the code to stop
    # you from doing so, though

    def initialize
      @value = {}
      @failure = {}
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
      def successful?
        true
      end

      def assoc(key, other, &blk)
        if other.successful?
          self.class.new.unit(value.merge(key => other.value))
        else
          Failure.new.fail(failure.merge(key => other.failure))
        end
      end
    end

    class Failure < Result
      def successful?
        false
      end

      def fail(failure)
        @failure = failure
        self
      end

      def assoc(key, other, &blk)
        if other.successful?
          self
        else
          self.class.new.fail(failure.merge(key => other.failure))
        end
      end
    end
  end
end
