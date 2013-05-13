class Dcp
  module Frames
    class Common

      # Service ID index.
      SERVICE_ID_INDEX = 16

      # Service type index.
      SERVICE_TYPE_INDEX = 17

      # Frame content range (skip header).
      FRAME_CONTENT_RANGE = 16..-1

      # Frame IDs.
      FRAME_ID = { hello_request: 0xFEFC, get_set: 0xFEFD, identify_request: 0xFEFE, identify_response: 0xFEFF }

      # Service IDs.
      SERVICE_ID = { get: 0x03, set: 0x04, identify: 0x05, hello: 0x06 }

      # Service types.
      SERVICE_TYPE = { request: 0x00, success_response: 0b001, error_response: 0b101 }

      # Response delay factor without spread.
      RESPONSE_DELAY = 0x0001


      # Frame service [Symbol] `hello`, `identify`, `get`, `set`. Coded as Usigned8.
      attr_accessor :service

      # Frame service type [Symbol] `request`, `response`. Coded as Unsigned8.
      attr_accessor :type

      # Transaction identification chosen by client [Fixnum]. Coded as Unsigned32.
      attr_accessor :xid

      # Frame blocks [Array<Frames::Object>].
      attr_accessor :blocks


      # Create frame from captured data.
      #
      # @param data [String] captured data
      # @return [Frames::Object] instance of proper class represents frame
      def self.create_from(data)
        service = SERVICE_ID.key(data[SERVICE_ID_INDEX].to_byte).to_s
        type    = (data[SERVICE_TYPE_INDEX].to_byte == 0) ? 'request' : 'response'
        klass   = "#{service}_#{type}".camelize

        if Dcp::Frames.constants.include?(klass.to_sym)
          frame = Dcp::Frames.const_get(klass).new
          frame.parse data[FRAME_CONTENT_RANGE]
          frame
        else
          nil
        end
      end

      # Frame initialization.
      #
      # @param service [Symbol] frame service: `hello`, `identify`, `get` and `set`
      # @param type [Symbol] `request` or `response`
      # @param xid [Fixnum] transaction identification
      def initialize(service, type, xid = nil)
        @service  = service
        @type     = type
        @xid      = xid || 0x01000001   # default Xid
        @blocks   = Array.new
      end

      # Returns requested frame block.
      #
      # @param option [Symbol] block option
      # @param suboption [Symbol] block suboption
      # @return requested block
      def block(option, suboption)
        @blocks.select { |block| block.option == option && block.suboption == suboption }.first
      end

      # Returns frame as byte array.
      #
      # Header is coded as: ServiceId [1B], ServiceType [1B], Xid [4B], ResponseDelayFactor or padding [2B], DCPDataLength [2B].
      # @return [String] serialized frame
      def to_b
        service_id      = SERVICE_ID[@service].to_byte
        service_type    = SERVICE_TYPE[@type].to_byte
        xid             = @xid.to_double
        response_delay  = 0x0001.to_word            # response delay factor without spread
        blocks          = @blocks.map(&:to_b).join
        length          = blocks.length.to_word

        "#{frame_id}#{service_id}#{service_type}#{xid}#{response_delay}#{length}#{blocks}"
      end

      # Parse captured data.
      def parse(data)
        # parse header
        @service    = SERVICE_ID.key(data[0].to_byte)
        @type       = SERVICE_TYPE.key(data[1].to_byte)
        @xid        = data[2..5].to_double
        length      = data[8..9].to_word
        data = data.slice 10, length

        # parse blocks
        until data.empty?
          block = Dcp::Blocks::Common.create_from(data)
          @blocks.push(block) if block
        end
      end


      private

        # Returns FrameId.
        #
        # @return [Fixnum] Frame ID
        def frame_id
          res = case service
            when :hello
              FRAME_ID[:hello_request]
            when :identify
              FRAME_ID[:identify_request]
            when :get, :set
              FRAME_ID[:get_set]
          end

          res.to_word
        end

    end
  end
end
