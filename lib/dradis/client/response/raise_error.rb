require 'faraday'

module Dradis
  module Client
    module Response
      class RaiseError < Faraday::Response::Middleware
        def on_complete(response)
          status_code = response.status.to_i
          klass = Dradis::Client::Error.errors[status_code]
          if klass
            error = klass.from_response(response)
            fail(error)
          end
        end
      end
    end
  end
end

Faraday::Response.register_middleware raise_error: Dradis::Client::Response::RaiseError