require_relative 'common'

class Dcp
  module Blocks
    class IpIp < Common

      # IP address [String]. Coded as OctetString[4].
      attr_accessor :ip_address

      # Subnet mask [String]. Coded as OctetString[4].
      attr_accessor :subnet_mask

      # Standard gateway [String]. Coded as OctetString[4].
      attr_accessor :standard_gateway


      # IpParameters block initialization.
      #
      # @param ip_address [String] IP address
      # @param subnet_mask [String] subnet mask
      # @param standard_gateway [String] standard mask
      # @param change_duration [Symbol] change duration as `permanent` or `temporary`
      def initialize(ip_address = '0.0.0.0', subnet_mask = '0.0.0.0', standard_gateway = '0.0.0.0', change_duration = :temporary)
        super :ip, :ip
        @ip_address       = ip_address
        @subnet_mask      = subnet_mask
        @standard_gateway = standard_gateway
        @block_info       = CHANGE_DURATION[change_duration].to_word
      end

      # Returns block content.
      #
      # @return [String] IP parameterss
      def content
        [@block_info, @ip_address.to_b, @subnet_mask.to_b, @standard_gateway.to_b].join
      end

      # Parse IpParamenters block content.
      def parse(data)
        super data
        @ip_address       = data[0..3].to_ip
        @subnet_mask      = data[4..7].to_ip
        @standard_gateway = data[8..11].to_ip
      end

    end
  end
end
