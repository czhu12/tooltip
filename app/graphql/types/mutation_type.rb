module Types
  class MutationType < Types::BaseObject
    graphql_name 'Mutation'

    include ::Graphql::MountMutation
    mount_mutation Mutations::ScriptMutations::Create
    mount_mutation Mutations::ScriptMutations::Update
  end
end
