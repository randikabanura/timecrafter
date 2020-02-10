require 'active_support'
require 'active_support/all'

module Timecrafter
  module OptionHandling

    def self.handle(options)
      options.each do |k, v|
        case k
        when :precision
          error_handling_number(k, v)
        when :seconds
          error_handling_boolean(k, v)
        when :theme
          error_handling_theme(v)
        else
          not_available_argument(k, v)
        end
      end
    end

    private


    def self.error_handling_number(key, number)
      raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." unless number.is_a? Numeric
      raise ArgumentError, "#{key.to_s.titleize} argument is negative." if number.negative?
      raise ArgumentError, "#{key.to_s.titleize} argument cannot be less than 2." if number < 2
    end

    def self.error_handling_boolean(key, boolean)
      raise ArgumentError, "#{key.to_s.titleize} argument is not boolean." unless [true, false].include? boolean
    end

    def self.not_available_argument(key, number)
      raise ArgumentError, "#{key.to_s.titleize} argument is not a available argument."
    end

    def self.error_handling_theme(theme)
      raise ArgumentError, 'Theme argument is not valid.' unless ['short', 'long'].include? theme
    end
  end
end
