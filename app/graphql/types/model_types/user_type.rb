module Types::ModelTypes
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :email, String, null: false
  end
end
