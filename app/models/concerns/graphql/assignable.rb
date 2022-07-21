module Graphql
  module Assignable
    extend ActiveSupport::Concern

    class_methods do
      def attributes_from_graphql_input(attrs)
        return {} if attrs.nil?

        self::GRAPHQL_ATTRIBUTES.each_with_object({}) do |key, h|
          h[key] = attrs.public_send(key) if attrs.respond_to?(key)
        end
      end
    end
  end
end

