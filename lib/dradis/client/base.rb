module Dradis
  module Client
    class Base
      attr_reader :attrs

      # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
      #
      # @overload self. attr_reader(attr)
      # @param attr [Symbol]
      # @overload self. attr_reader(attrs)
      # @param attrs [Array<Symbol>]
      def self.attr_reader(*attrs)
        attrs.each do |attribute|
          class_eval do
            define_method attribute do
              @attrs[attribute.to_sym]
            end
          end
        end
      end


      # Initializes a new object
      #
      # @param attrs [Hash]
      # @return [Twitter::Base]
      def initialize(attrs = {})
        @attrs = attrs || {}
      end
    end
  end
end