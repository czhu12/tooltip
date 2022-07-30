module Types::ModelTypes
  class ScriptType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :id, Integer, null: false
    field :title, String, null: false
    field :slug, String, null: false
    field :description, String, null: true
    field :code, String, null: true
    field :run_count, Integer, null: false
    field :user, Types::ModelTypes::UserType, null: true
    field :visibility, String, null: true
  end
end
