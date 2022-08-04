module Types
  class MutationType < Types::BaseObject
    graphql_name 'Mutation'

    include ::Graphql::MountMutation
    mount_mutation Mutations::ScriptMutations::Create
    mount_mutation Mutations::ScriptMutations::Update
    mount_mutation Mutations::UserMutations::SignIn
    mount_mutation Mutations::UserMutations::SignUp
    mount_mutation Mutations::UserMutations::UpdateUser
  end
end
