require_relative 'common'

class Dcp
  module Frames
    class SetRequest < Common

      # Set request frame initialization.
      def initialize
        super :set, :request
      end

      # Add NameOfStation block.
      #
      # @param name_of_station [String] name of station
      # @param change_duration [Symbol] change duration as `permanent` or `temporary`
      def name(name_of_station, change_duration)
        @blocks.push Dcp::Blocks::DeviceName.new(name_of_station, change_duration)
        self
      end

      # Add IpParameters block.
      #
      # @param ip_address [String] IP address
      # @param subnet_mask [String] subnet mask
      # @param standard_gateway [String] standard mask
      # @param change_duration [Symbol] change duration as `permanent` or `temporary`
      def ip(ip_address, subnet_mask, standard_gateway, change_duration)
        @blocks.push Dcp::Blocks::IpIp.new(ip_address, subnet_mask, standard_gateway, change_duration)
        self
      end

      # Add ControlSignal block.
      def signal
        @blocks.push Dcp::Blocks::ControlSignal.new
        self
      end

      # Add ControlFactoryReset block.
      def factory_reset
        @blocks.push Dcp::Blocks::ControlFactoryReset.new
        self
      end

    end
  end
end
