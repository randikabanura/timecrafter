require "timecrafter/version"

module Timecrafter
  class Error < StandardError; end

  def self.humanize_hourly(hours, _options = {})
    hours = hours.to_f
    hour = hours.to_i
    minutes_fraction = hours.modulo(1).round(2)

    minutes = (60 * minutes_fraction).to_i
    create_default_hourly(hour, minutes)
  end


  private

  def self.create_default_hourly(hour, minutes)
    hourly_humanize = ''

    if more_than_zero?(hour)
      hourly_humanize += "#{hour} hour#{'s' if more_than_one?(hour)}"
    end

    hourly_humanize += " #{minutes} minute#{'s' if more_than_one?(minutes)}"
    hourly_humanize.strip
  end

  def self.more_than_zero?(number)
    number.positive?
  end

  def self.more_than_one?(number)
    number > 1
  end
end
