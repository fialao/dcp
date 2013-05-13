require_relative 'common'

class Dcp
  module Frames
    class SetResponse < Common

      # Set response frame initialization.
      def initialize
        super :set, :response
      end

    end
  end
end
