require_relative 'common'

class Dcp
  module Blocks
    class DeviceRole < Common

      # Device roles [Array<Symbol>]. 
      #
      # IO-Device (Bit 0), IO-Controller (Bit 1), IO-Multidevice (Bit 2), IO-Supervisor (Bit 3).
      attr_reader :roles


      # DeviceRole block initialization.
      def initialize
        super :device, :role
        @roles = Array.new
      end

      # Parse DeviceRole block content.
      def parse(data)
        super data
        data = data.to_byte
        @roles.push :device       if (data & 0b0001) > 0
        @roles.push :controller   if (data & 0b0010) > 0
        @roles.push :multidevice  if (data & 0b0100) > 0
        @roles.push :supervisor   if (data & 0b1000) > 0
      end

    end
  end
end
