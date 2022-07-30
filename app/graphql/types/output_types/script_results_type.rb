module Types::OutputTypes
  class ScriptResultsType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :scripts, [Types::ModelTypes::ScriptType], null: true
    field :total_pages, Integer, null: false
  end
end
