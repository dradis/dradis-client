module Dradis
  module Client
    # Custom error class for rescuing from all Dradis client errors
    class Error < StandardError
      attr_reader :code


      # --------------------------------------------------------- Class methods

      # Create a new error from an HTTP response
      #
      # @param response [Faraday::Response]
      # @return [Dradis::Client::Error]
      def self.from_response(response)
        message, code = parse_error(response.body)
        # new(message, response.response_headers, code)
        new(message, code)
      end

      # @return [Hash]
      def self.errors
        @errors ||= {
                  # 400 => Twitter::Error::BadRequest,
                  401 => Dradis::Client::Error::Unauthorized,
                  # 403 => Twitter::Error::Forbidden,
                  # 404 => Twitter::Error::NotFound,
                  # 406 => Twitter::Error::NotAcceptable,
                  # 408 => Twitter::Error::RequestTimeout,
                  # 422 => Twitter::Error::UnprocessableEntity,
                  # 429 => Twitter::Error::TooManyRequests,
                  # 500 => Twitter::Error::InternalServerError,
                  # 502 => Twitter::Error::BadGateway,
                  # 503 => Twitter::Error::ServiceUnavailable,
                  # 504 => Twitter::Error::GatewayTimeout,
                }
      end




      # ------------------------------------------------------ Instance methods

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

      # Raised when Dradis returns the HTTP status code 401
      class Unauthorized < ClientError; end


      private

      def self.parse_error(body)
        if body.nil?
          ['', nil]
        elsif body[:message]
          [body[:message], nil]
        # elsif body[:errors]
        #   extract_message_from_errors(body)
        end
      end
    end
  end
end
