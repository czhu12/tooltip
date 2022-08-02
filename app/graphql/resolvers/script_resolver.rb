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

  class ListPublicScripts < Resolvers::BaseResolver
    type Types::OutputTypes::ScriptResultsType, null: false
    argument :page, Int
    argument :owner_id, Int, required: false
    argument :q, String, required: false

    def resolve(page:, owner_id: nil, q: nil)
      result = Scripts::List.execute(
        filters: {
          q: q,
          owner_id: owner_id,
        },
        current_user: context[:current_user],
        page: page,
      )
      {scripts: result.scripts, total_pages: 1}
    end
  end
end

