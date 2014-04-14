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

      # Raised when one of the config values is invalid
      class ConfigurationError < ::ArgumentError; end

      # Raised when Dradis returns a 4xx HTTP status code
      class ClientError < self; end

    end
  end
end
