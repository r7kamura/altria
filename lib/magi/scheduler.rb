module Magi
  class Scheduler
    CRON_REGEXP = /\A(\d+|\*) (\d+|\*) (\d+|\*) (\d+|\*) (\d+|\*)\s*\z/

    # Takes a schedule as a String.
    def initialize(schedule)
      @result, @min, @hour, @day, @month, @wday = *schedule.match(CRON_REGEXP)
      validate
    end

    def scheduled?
      [:min, :hour, :day, :month, :wday].all? do |key|
        send(key).nil? || send(key) == now.send(key)
      end
    end

    private

    def min
      @min.to_i if @min != "*"
    end

    def hour
      @hour.to_i if @hour != "*"
    end

    def day
      @day.to_i if @day != "*"
    end

    def month
      @month.to_i if @month != "*"
    end

    def wday
      @wday.to_i if @wday != "*"
    end

    def now
      @now ||= Time.now
    end

    def validate
      raise_argument_error unless valid?
    end

    def valid?
      !!@result
    end

    def raise_argument_error
      raise ArgumentError, "Input must match with #{CRON_REGEXP}"
    end
  end
end
