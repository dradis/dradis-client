module Dradis
  module Client
    class Note < Dradis::Client::Base
      attr_reader :id, :category_id, :text

      # Parse a Note's :text field and splits it to return a Hash of field name/value
      # pairs as described in the class description above.
      #
      # If the :text field format does not conform to the expected syntax, an empty
      # Hash is returned.
      def fields
        begin
          Hash[ *self.text.scan(/#\[(.+?)\]#[\r|\n](.*?)(?=#\[|\z)/m).flatten.collect do |str| str.strip end ]
        rescue
          # if the note is not in the expected format, just return an empty hash
          {}
        end
      end

      # Extract the Title field from the note's text
      def title
        fields.fetch('Title', "This Note doesn't provide a Title field")
      end
    end
  end
end
