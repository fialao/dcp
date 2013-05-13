require_relative 'common'

class Dcp
  module Blocks
    class DeviceVendor < Common

      # Type of station [String]. Coded as OctetString with 1 to 240 octets.
      attr_reader :type_of_station


      # DeviceVendor block initialization.
      def initialize
        super :device, :vendor
      end

      # Parse DeviceVendor block content.
      def parse(data)
        super data
        @type_of_station = data
      end

    end
  end
end
