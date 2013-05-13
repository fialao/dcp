require_relative 'common'

class Dcp
  module Frames
    class IdentifyRequest < Common

      # Idetify request frame initialization.
      def initialize
        super :identify, :request
      end

      # Add identify all block.
      def all
        @blocks.push Dcp::Blocks::AllAll.new
        self
      end

    end
  end
end
