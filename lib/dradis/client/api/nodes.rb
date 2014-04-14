module Dradis
  module Client
    module API
      module Nodes
        MAX_NODES_PER_REQUEST = 100

        # Returns extended information for up to 100 nodes
        #
        # @see http://dradisframework.org/docs/api/v1/#users
        # @authentication Requires user context
        # @raise [Dradis::Client::Error::Unauthorized] Error raised when supplied user credentials are not valid.
        # @return [Array<Dradis::Client::Node>] The requested nodes.
        # @overload nodes(*nodes)
        # @param nodes [Enumerable<Integer, Dradis::Client::Node>] A collection of Dradis node IDs, or objects.
        # @overload users(*nodes, options)
        # @param nodes [Enumerable<Integer, Dradis::Client::Node>] A collection of Dradis node IDs, or objects.
        # @param options [Hash] A customizable set of options.
        # @option options [Symbol, String] :method Requests users via a GET request instead of the standard POST request if set to ':get'.
        # @option options [Boolean] :include_entities The children node will be disincluded when set to false.
        def nodes(*args)
          arguments = Dradis::Client::Arguments.new(args)
          request_method = arguments.options.delete(:method) || :get
          # flat_pmap(arguments.each_slice(MAX_USERS_PER_REQUEST)) do |users|
            # perform_with_objects(request_method, '/api/nodes.json', merge_nodes(arguments.options, nodes), Dradis::Client::Node)
            perform_with_objects(request_method, '/api/nodes.json', arguments.options, Dradis::Client::Node)
          # end
        end

        # @see http://dradisframework.org/docs/api/v1/#users
        # @authentication Requires user context
        # @raise [Dradis::Client::Error::Unauthorized] Error raised when supplied user credentials are not valid.
        # @return [Dradis::Client::Node] The requested node.
        #
        # @overload node(options = {})
        # Returns extended information for the authenticated node
        # @param options [Hash] A customizable set of options.
        # @option options [Boolean] :include_entities The tweet entities node will be disincluded when set to false.
        # @option options [Boolean, String, Integer] :skip_status Do not include user's Tweets when set to true, 't' or 1.
        #
        # @overload node(node, options = {})
        # Returns extended information for a given node
        # @param node [Integer, Dradis::Client::Node] A Dradis node ID, or object.
        # @param options [Hash] A customizable set of options.
        # @option options [Boolean] :include_entities The tweet entities node will be disincluded when set to false.
        # @option options [Boolean, String, Integer] :skip_status Do not include user's Tweets when set to true, 't' or 1.
        def node(*args)
          arguments = Dradis::Client::Arguments.new(args)
          if arguments.last
            merge_node!(arguments.options, arguments.pop)
            perform_with_object(:get, '/api/nodes.json', arguments.options, Dradis::Client::node)
          else
            # verify_credentials(arguments.options)
          end
        end
      end
    end
  end
end