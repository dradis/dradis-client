module Dradis
  module Client
    module API
      module Notes

        # Adds a new note to a given node.
        #
        # @see http://dradisframework.org/docs/api/v1/#notes
        # @authentication Requires user context
        # @raise [Dradis::Client::Error::Unauthorized] Error raised when supplied user credentials are not valid.
        # @return [Dradis::Client::Note] The created note.
        # @param text [String] The text for the new note.
        # @param options [Hash] A customizable set of options.
        # @option options [Integer, Dradis::Client::Node] :node_id Specifies the parent node for the new note.
        # @option options [Integer] :category_id Specifies the category for the new note.
        def add_note(text, options={})

          # FIXME: this is a brittle assumption. Shouldn't we check?
          node_id = options.delete(:node_id)
          perform_with_object(:post, "/api/nodes/#{node_id}/notes.json", {note: options.merge(text: text)}, Dradis::Client::Note)
        end

        # Returns extended information for up to 100 notes
        #
        # @see http://dradisframework.org/docs/api/v1/#notes
        # @authentication Requires user context
        # @raise [Dradis::Client::Error::Unauthorized] Error raised when supplied user credentials are not valid.
        # @return [Array<Dradis::Client::Note>] The requested nodes.
        # @param node_id [Integer] The id of the parent node
        # @param options [Hash] A customizable set of options.
        def notes(node_id, options={})
          perform_with_objects(:get, "/api/nodes/#{node_id}/notes.json", options, Dradis::Client::Note)
        end

        # PENDING
        # def destroy_note(*args)
        # end
      end
    end
  end
end