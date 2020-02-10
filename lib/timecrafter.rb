require 'timecrafter/version'
require 'strptime'

module Timecrafter
  autoload :OptionHandling, 'timecrafter/options_handling'

  class Error < StandardError; end

  def self.humanize_hours(hours, _options = {})
    error_handling('Hour', hours)

    Timecrafter::OptionHandling.handle(_options)

    param_precision = _options[:precision] || 2
    param_seconds = _options[:seconds] || false
    param_theme = _options[:theme] || 'long'
    param_strftime = _options[:strftime] || '%H hours %M minutes'

    hours = hours.to_f
    hour = hour.to_i
    seconds = (hours * 60 * 60).round
    
    param_strftime += '%s' if param_seconds
    strftime = param_strftime

    create_default_hourly(seconds, hour, strftime)
  end

  def self.humanize_hours_to_seconds(hours, options = {})
    error_handling('Hour', hours)

    hours = hours.to_f
    seconds = (hours * 60 * 60).round

    "#{seconds} second#{'s' if more_than_one?(seconds)}"
  end

  def self.humanize_hours_to_minutes(hours, options = {})
    error_handling('Hour', hours)

    hours = hours.to_f
    minutes = (hours * 60).round

    "#{minutes} minute#{'s' if more_than_one?(minutes)}"
  end

  private

  def self.create_default_hourly(seconds, hour, strftime)
    Time.at(seconds).utc.strftime(strftime)
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
