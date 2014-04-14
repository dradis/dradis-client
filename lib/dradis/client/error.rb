module Dradis
  module Client
    # Custom error class for rescuing from all Dradis client errors
    class Error < StandardError
      attr_reader :code

      # Initializes a new Error object
      #
      # @param exception [Exception, String]
      # @param code [Integer]
      # @return [Dradis::Client::Error]
      def initialize(message = '', code = nil)
        super(message)
        @code = code
      end

      class ConfigurationError < ::ArgumentError; end
    end
  end
end
