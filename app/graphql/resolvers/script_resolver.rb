module Resolvers::ScriptResolver
  class FetchScript < Resolvers::BaseResolver
    include Graphql::Pundit::Authorize

    type Types::ModelTypes::ScriptType, null: true

    argument :slug, String

    pundit_role :show?
    pundit_policy_class ScriptPolicy

    def resolve(slug:)
      script = Script.find_by_slug(slug)
      if context[:current_user].present?
        authorize!(script)
      end

      script
    end
  end

  class ListUserScripts < Resolvers::BaseResolver
    include Graphql::Pundit::Authorize

    type [Types::ModelTypes::ScriptType], null: true

    def resolve
      authenticate!

      context[:current_user].scripts
    end
  end

  class ListPublicScripts < Resolvers::BaseResolver
    type [Types::ModelTypes::ScriptType], null: true
    argument :page, Int

    def resolve(page:)
      result = Scripts::List.execute(filters: {}, page: page)
      result.scripts
    end
  end
end

