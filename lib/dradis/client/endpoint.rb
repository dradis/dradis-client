module Dradis
  module Client
    class Endpoint
      attr_accessor :host, :shared_secret, :user

      # Initializes a new Endpoint object
      #
      # @param options [Hash]
      # @return [Dradis::Client::Endpoint]
      def initialize(options = {})
        options.each do |key, value|
          send(:"#{key}=", value)
        end
        yield(self) if block_given?

        validate_credential_type!
        validate_host!
      end

      # @return [Hash]
      def credentials
        {
         :shared_secret => shared_secret
        }
      end

      def user
        @user ||= 'Ruby API client'
      end

      # @return [String]
      def user_agent
        @user_agent ||= "Dradis Ruby Gem #{Dradis::Client::Version}"
      end

      private

        # Ensures that all credentials set during configuration are of a
        # valid type. Valid types are String and Symbol.
        #
        # @raise [Dradis::Client::Error::ConfigurationError] Error is raised when
        # supplied dradis credentials are not a String or Symbol.
        def validate_credential_type!
          credentials.each do |credential, value|
            next if value.nil?
            fail(Dradis::Client::Error::ConfigurationError.new("Invalid #{credential} specified: #{value.inspect} must be a string or symbol.")) unless value.is_a?(String) || value.is_a?(Symbol)
          end
        end

        # Ensures that the host provided is a valid URL
        #
        # @raise [Dradis::Client::Eror::ConfigurationError] Error is raised when
        # supplied host can't be resolved as an URL.
        def validate_host!
          begin
            URI.parse(host)
          rescue URI::Error => e
            fail(Dradis::Client::Error::ConfigurationError.new("Invalid host URL provided: #{host.inspect}"))
          end
        end
    end
  end
end