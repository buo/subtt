module Subtt
  class Duration
    include Comparable
    attr :ms, :hours, :minutes, :seconds, :miliseconds

    def initialize(other)
      set other
    end

    def coerce(other)
      return Duration.new(other), self
    end

    def set(other)
      @ms = other

      @hours = (other / 3600000).to_i
      other -= @hours * 3600000

      @minutes = (other / 60000).to_i
      other -= @minutes * 60000

      @seconds = (other / 1000).to_i
      other -= @seconds * 1000

      @miliseconds = other
    end

    def to_s
      "%02d:%02d:%02d,%03d" % [@hours, @minutes, @seconds, @miliseconds]
    end

    def <=>(other)
      @ms <=> other.ms
    end
  end
end
