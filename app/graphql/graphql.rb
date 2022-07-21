module Graphql
  module MountMutation
    extend ActiveSupport::Concern

    class_methods do
      def mount_mutation(mutation_class, **custom_kwargs)
        field mutation_class.graphql_name.underscore.to_sym,
          mutation: mutation_class,
          **custom_kwargs
      end
    end
  end

  module Pundit
    class SessionExpiredError < ::Pundit::Error
      def initialize
        super('Session expired')
      end
    end

    class AuthenticationError < ::Pundit::Error
      def initialize
        super('You must be authenticated')
      end
    end

    module Authorize
      extend ActiveSupport::Concern

      included do
        def pundit_role
          self.class.class_variable_get(:@@pundit_role)
        end

        def pundit_policy_class
          self.class.class_variable_get(:@@pundit_policy_class)
        end
      end

      class_methods do
        def pundit_role(new_role = nil)
          class_variable_set(:@@pundit_role, new_role)
        end

        def pundit_policy_class(new_policy_class = nil)
          class_variable_set(:@@pundit_policy_class, new_policy_class)
        end
      end

      def authorize!(record = nil)
        authenticate!
        context[:authorize].call record, pundit_role, policy_class: pundit_policy_class
      end

      def authenticate!
        raise SessionExpiredError if context[:authentication_result] == :failure
        raise AuthenticationError unless context[:current_user].present?
      end
    end
  end

end
