require_relative 'common'

class Dcp
  module Blocks
    class ControlSignal < Common

      # Signal value.
      FLASH_ONCE = 0x0100


      # ControlSignal block initialization.
      def initialize
        super :control, :signal
      end

      # Returns block content.
      #
      # ControlSignal block has default BlockQualifier and SignalValue
      # @return [String] empty string
      def content
        [0x0000.to_word, FLASH_ONCE.to_word].join
      end

    end
  end
end
