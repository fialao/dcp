require_relative 'common'

class Dcp
  module Blocks
    class AllAll < Common

      # AllSelector block initialization.
      def initialize
        super :all, :all
      end

      # Returns block content.
      #
      # AllSelector block hasn't any content.
      # @return [String] empty string
      def content
        ''
      end

    end
  end
end
