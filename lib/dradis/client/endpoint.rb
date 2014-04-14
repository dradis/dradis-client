module Dradis
  module Client
    class Endpoint
      attr_accessor :host, :shared_secret, :user


      # ------------------------------------------ Generic client configuration

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


      # ---------------------------------------- REST HTTP client configuration

      # @return [Hash]
      def connection_options
        @connection_options ||= {
          :builder => middleware,
          :headers => {
            :accept => 'application/json',
            :accept => 'application/vnd.dradisapi; v=1',
            :user_agent => user_agent,
          },
          # :raw => true,
          :request => {
            :open_timeout => 10,
            :timeout => 30,
          },
          :ssl => {:verify => false}
        }
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware. The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::RackBuilder]
      def middleware
        @middleware ||= Faraday::RackBuilder.new do |faraday|
          # Convert file uploads to Faraday::UploadIO objects
          # faraday.request :multipart_with_file
          # Checks for files in the payload, otherwise leaves everything untouched
          # faraday.request :multipart
          # Encodes as "application/x-www-form-urlencoded" if not already encoded
          faraday.request :url_encoded
          # Handle error responses
          faraday.response :raise_error
          # Parse JSON response bodies
          faraday.response :parse_json
          # Set default HTTP adapter
          faraday.adapter :net_http
        end
      end

      # Perform an HTTP GET request
      def get(path, params = {})
        headers = request_headers(:get, path, params)
        request(:get, path, params, headers)
      end

      # Perform an HTTP POST request
      def post(path, params = {})
        headers = params.values.any? { |value| value.respond_to?(:to_io) } ? request_headers(:post, path, params, {}) : request_headers(:post, path, params)
        request(:post, path, params, headers)
      end

      private

        # --------------------------------------------------------- Validations

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


        # --------------------------------------------------------- Faraday ops

         # Returns a Faraday::Connection object
         #
         # @return [Faraday::Connection]
         def connection
           @connection ||= Faraday.new(host, connection_options)
         end

         def request(method, path, params = {}, headers = {})
           connection.send(method.to_sym, path, params) { |request| request.headers.update(headers) }.env
         rescue Faraday::Error::TimeoutError, Timeout::Error => error
           raise(Dradis::Client::Error::RequestTimeout.new(error))
         rescue Faraday::Error::ClientError, JSON::ParserError => error
           raise(Dradis::Client::Error.new(error))
         end

         def request_headers(method, path, params = {}, signature_params = params)
           bearer_token_request = params.delete(:bearer_token_request)
           headers = {}
           headers[:authorization] = auth_header
           headers
         end

         def auth_header
           if shared_secret
             # Basic auth
             "Basic %s" % Base64::strict_encode64([user, shared_secret].join(':'))
           else
             # API token
             # "Token token=\"\""
           end
         end
    end
  end
end