module Dradis
  module Client
    class Node < Dradis::Client::Base
      attr_reader :id, :label, :type_id, :parent_id
    end
  end
end
