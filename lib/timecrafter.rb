require 'timecrafter/version'

module Timecrafter
  autoload :OptionHandling, 'timecrafter/options_handling'

  class Error < StandardError; end

  def self.humanize_hourly(hours, _options = {})
    error_handling("Hour", hours)

    Timecrafter::OptionHandling.handle(_options)

    hours = hours.to_f
    hour = hours.to_i
    precision = _options[:precision] || 2
    
    minutes_fraction = hours.modulo(1).round(precision)

    minutes = (60 * minutes_fraction).to_i
    create_default_hourly(hour, minutes)
  end


  private

  def self.create_default_hourly(hour, minutes)
    hourly_humanize = ''

    if more_than_zero?(hour)
      hourly_humanize += "#{hour} hour#{'s' if more_than_one?(hour)}"
    end

    if more_than_zero?(minutes)
      hourly_humanize += " #{minutes} minute#{'s' if more_than_one?(minutes)}"
    end
    hourly_humanize.strip
  end

  def self.more_than_zero?(number)
    number.positive?
  end

  def self.more_than_one?(number)
    number > 1
  end

  def self.error_handling(key, hour)
    raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." unless hour.is_a? Numeric
    raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." if hour.negative?
  end
end
