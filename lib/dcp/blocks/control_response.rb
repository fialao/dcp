require_relative 'common'

class Dcp
  module Blocks
    class ControlResponse < Common

      # Response errors.
      RESPONSE_ERROR = { ok: 0x00, option_not_supported: 0x01, suboption_not_supported: 0x02, suboption_not_set: 0x03, \
                         resource_error: 0x04, set_not_possible_by_local: 0x05, set_not_possible: 0x06 }


      # Response option [Symbol] `ip`, `device`, `all`. Coded as Unsigned8.
      attr_reader :response_option

      # Response suboption [Symbol] Coded as Unsigned8.
      attr_reader :response_suboption

      # Response error [Symbol] Coded as Unsigned8.
      attr_reader :response_error

      # ControlResponse block initialization.
      def initialize
        super :control, :response
      end


      # Parse ControlResponse block content.
      def parse(data)
        @response_option    = OPTION.key(data[0].to_byte)
        @response_suboption = Dcp::Blocks::Common.const_get("#{@response_option.upcase}_SUBOPTION").key(data[1].to_byte)
        @response_error     = RESPONSE_ERROR.key(data[2].to_byte)
      end

    end
  end
end
