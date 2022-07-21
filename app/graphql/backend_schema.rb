class BackendSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    # TODO: Implement this method
    # to return the correct GraphQL object type for `obj`
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Relay-style Object Identification:

  # TODO: Remove development cond branches when releasing product
  # Return a string UUID for `object`
  def self.id_from_object(object, _type_definition, _query_ctx)
    if Rails.env.development?
      "#{object.class.name}-#{object.id}"
    else
      object.to_gid_param
    end
  end

  # List only Types that implement GraphQL::Types::Relay::Node
  def self.resolve_type(_type, obj, _ctx)
    case obj
    when User
      Types::ModelTypes::UserType
    when Script
      Types::ModelTypes::ScriptType
    else
      raise("Unexpected object: #{obj}")
    end
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, _query_ctx)
    if Rails.env.development?
      class_name, id = global_id.split('-')
      Object.const_get(class_name).find_by(id: id)
    else
      GlobalID.find(global_id)
    end
  end

  rescue_from(Pundit::NotAuthorizedError) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, err.message
  end
end
