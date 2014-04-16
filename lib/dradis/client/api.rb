require 'dradis/client/api/nodes'
require 'dradis/client/api/notes'

module Dradis
  module Client
    module API
      include Dradis::Client::API::Nodes
      include Dradis::Client::API::Notes

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_with_object(request_method, path, options, klass)
        request = Dradis::Client::Request.new(self, request_method, path, options)
        request.perform_with_object(klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_with_objects(request_method, path, options, klass)
        request = Dradis::Client::Request.new(self, request_method, path, options)
        request.perform_with_objects(klass)
      end
    end
  end
end