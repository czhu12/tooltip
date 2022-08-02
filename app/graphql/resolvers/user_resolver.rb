module Resolvers::UserResolver
  class FetchCurrentUser < Resolvers::BaseResolver
    type Types::ModelTypes::UserType, null: false

    def resolve
      context[:current_user]
    end
  end
end