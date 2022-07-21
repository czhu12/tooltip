module Mutations::ScriptMutations
  class Create < Mutations::BaseMutation
    include Graphql::Pundit::Authorize

    graphql_name 'createScript'

    argument :attributes, Types::InputTypes::ScriptAttributes, required: true

    field :script, Types::ModelTypes::ScriptType, null: true
    field :errors, [String], null: true

    description 'Creates a script'

    def resolve(args)
      params = Script.attributes_from_graphql_input(args[:attributes])
      script = Script.new(params)

      debugger
      if script.save
        { script: script }
      else
        { errors: script.errors.full_messages }
      end
    end
  end

  class Update < Mutations::BaseMutation
    include Graphql::Pundit::Authorize

    graphql_name 'updateScript'

    argument :id, Integer, required: true
    argument :attributes, Types::InputTypes::ScriptAttributes, required: true

    field :script, Types::ModelTypes::ScriptType, null: true
    field :errors, [String], null: true

    description 'Updates a script'

    def resolve(args)
      params = Script.attributes_from_graphql_input(args[:attributes])
      script = Script.find(args[:id])

      if script.update(params)
        { script: script }
      else
        { errors: script.errors.full_messages }
      end
    end
  end
end

