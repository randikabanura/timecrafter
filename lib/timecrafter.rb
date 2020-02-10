require 'timecrafter/version'

module Timecrafter
  autoload :OptionHandling, 'timecrafter/options_handling'

  class Error < StandardError; end

  def self.humanize_hourly(hours, _options = {})
    error_handling("Hour", hours)

    Timecrafter::OptionHandling.handle(_options)

    hours = hours.to_f
    hour = hours.to_i

    param_precision = _options[:precision] || 2
    param_seconds = _options[:seconds] || false
    param_theme = _options[:theme] || 'long'

    minutes_fraction = hours.modulo(1).round(param_precision)

    theme = param_theme
    seconds = nil
    minutes = if !param_seconds
                get_fraction(60, minutes_fraction)
              else
                get_fraction(60, minutes_fraction, param_precision)
              end

    if param_seconds
      seconds_fraction = minutes.modulo(1).round(param_precision)
      seconds = get_fraction(60, seconds_fraction)
      minutes = minutes.floor
    end

    create_default_hourly(hour, minutes, seconds, theme)
  end


  private

  def self.create_default_hourly(hour, minutes, seconds = nil, theme = 'long')
    hourly_humanize = ''

    if more_than_zero?(hour)
      hourly_humanize += "#{hour} hour#{'s' if validate_theme_number(hour, theme)}"
    end

    if more_than_zero?(minutes) || seconds&.positive?
      hourly_humanize += " #{minutes} minute#{'s' if validate_theme_number(minutes, theme)}"
    end

    if seconds&.positive?
      hourly_humanize += " #{seconds} second#{'s' if validate_theme_number(seconds, theme)}"
    end

    hourly_humanize.strip
  end

  def self.more_than_zero?(number)
    number.positive?
  end

  def self.more_than_one?(number)
    number > 1
  end

  def self.get_fraction(multiplier, fraction, precision = 0)
    (multiplier * fraction).round(precision)
  end
  
  def self.validate_theme_number(number, theme)
    more_than_one?(number) && theme == 'long'
  end

  def self.error_handling(key, hour)
    raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." unless hour.is_a? Numeric
    raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." if hour.negative?
  end
end
