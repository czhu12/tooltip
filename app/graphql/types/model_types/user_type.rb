module Types::ModelTypes
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :id, Int, null: false
    field :email, String, null: false
    field :username, String, null: false
    field :personal_website, String, null: true
  end
end
