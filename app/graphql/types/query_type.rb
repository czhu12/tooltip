module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :script, resolver: Resolvers::ScriptResolver::FetchScript,
      description: "Fetch script"

    field :popular_scripts, resolver: Resolvers::ScriptResolver::ListPublicScripts,
      description: "Fetch popular scripts"

    field :user_scripts, resolver: Resolvers::ScriptResolver::ListUserScripts,
      description: "Fetch user scripts"
  end
end
