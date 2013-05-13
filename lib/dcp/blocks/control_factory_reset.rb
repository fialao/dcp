require_relative 'common'

class Dcp
  module Blocks
    class ControlFactoryReset < Common

      # ControlFactoryReset block initialization.
      def initialize
        super :control, :factory_reset
      end

      # Returns block content.
      #
      # ControlFactoryReset block has only default BlockQualifier.
      # @return [String] empty string
      def content
        0x0000.to_word
      end

    end
  end
end
