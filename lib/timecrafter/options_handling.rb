require 'active_support'
require 'active_support/all'

module Timecrafter
  module OptionHandling

    def self.handle(options)
      options.each do |k, v|
        case k
        when :precision
          error_handling_number(k, v)
        else
        
        end
      end
    end

    private


    def self.error_handling_number(key, number)
      raise ArgumentError, "#{key.to_s.titleize} argument is not numeric." unless number.is_a? Numeric
      raise ArgumentError, "#{key.to_s.titleize} argument is negative." if number.negative?
    end
    
    def not_available_argument(key, number)
      raise ArgumentError, "#{key.to_s.titleize} argument is not a available argument."
    end
  end
end
