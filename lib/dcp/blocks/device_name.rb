require_relative 'common'

class Dcp
  module Blocks
    class DeviceName < Common

      # Name of station [String]. Coded as OctetString with 1 to 240 octets.
      attr_accessor :name_of_station


      # NameOfStation block initialization.
      #
      # @param name_of_station [String] name of station
      # @param change_duration [Symbol] change duration as `permanent` or `temporary`
      def initialize(name_of_station = nil, change_duration = :temporary)
        super :device, :name
        @name_of_station  = name_of_station
        @block_info       = CHANGE_DURATION[change_duration].to_word
      end

      # Returns block content.
      #
      # @return [String] block qualifier and name of station
      def content
        [@block_info, @name_of_station].join
      end

      # Parse NameOfStation block content.
      def parse(data)
        super data
        @name_of_station = data
      end

    end
  end
end
