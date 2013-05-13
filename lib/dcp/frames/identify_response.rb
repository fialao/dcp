require_relative 'common'

class Dcp
  module Frames
    class IdentifyResponse < Common

      # IdetifyAll request frame initialization.
      def initialize
        super :identify, :response
      end

    end
  end
end
