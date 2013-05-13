class Dcp
  module Blocks
    class Common

      # Block options.
      OPTION = { ip: 0x01, device: 0x02, dhcp: 0x03, control: 0x05, all: 0xFF }

      # IP block suboptions.
      IP_SUBOPTION = { mac: 0x01, ip: 0x02, full: 0x03 }

      # Device block suboptions.
      DEVICE_SUBOPTION = { vendor: 0x01, name: 0x02, id: 0x03, role: 0x04, options: 0x05, alias_name: 0x06 }

      # Control suboptions.
      CONTROL_SUBOPTION = { start: 0x01, stop: 0x02, signal: 0x03, response: 0x04, factory_reset: 0x05, reset_to_factory: 0x06 }

      # All block suboptions.
      ALL_SUBOPTION = { all: 0xFF }

      # Determine change duration.
      CHANGE_DURATION = { temporary: 0, permanent: 1 }


      # Block option [Symbol] `ip`, `device`, `all`. Coded as Unsigned8.
      attr_accessor :option

      # Block suboption [Symbol] Coded as Unsigned8.
      attr_accessor :suboption

      # Block info/qualifier. Coded as Unsigned16.
      attr_accessor :block_info


      # Create frame from captured data.
      #
      # @param data [String] captured data
      # @return [Blocks::Object] instance of proper class represents block
      def self.create_from(data)
        # block type
        option          = OPTION.key(data[0].to_byte).to_s
        suboption_hash  = "#{option.upcase}_SUBOPTION"
        suboption       = const_get(suboption_hash).key(data[1].to_byte).to_s if constants.include?(suboption_hash.to_sym)
        length          = data[2..3].to_word

        # slice block from data
        data.slice! 0, 4                    # header
        content = data.slice! 0, length     # content without block_info
        data.slice! 0 if length.odd?        # padding

        # create block
        klass = "#{option}_#{suboption}".camelize
        if Dcp::Blocks.constants.include?(klass.to_sym)
          block = Dcp::Blocks.const_get(klass).new
          block.parse content
          block
        else
          nil
        end
      end

      # Block initialization.
      #
      # @param option [Symbol] block option
      # @param suboption [Symbol] block suboption
      def initialize(option, suboption)
        @option     = option
        @suboption  = suboption
      end

      # Returns block as byte array.
      #
      # Coded as: Option [1b], Suboption [1B], DCPDataLength [2B], content [nB]. Block has Unsigned16 alignment.
      # @return [String] serialized block
      def to_b
        option    = OPTION[@option].to_byte
        suboption = Common.const_get("#{@option.upcase}_SUBOPTION")[@suboption].to_byte
        length    = content.length.to_word
        padding   = content.length.odd? ? "\x00" : ''

        "#{option}#{suboption}#{length}#{content}#{padding}"
      end

      # Parse block content.
      def parse(data)
        @block_info = data[0..1].to_word
        data.slice! 0, 2
      end

    end
  end
end
