class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  before_action :set_current_user

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      authentication_result: authentication_result,
      authorize: ->(r, q = nil, policy_class: nil) { authorize(r, q, policy_class: policy_class) }
    }
    result = BackendSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue Pundit::NotAuthorizedError => e
    # This rescue branch is not working, possibly linked to
    # https://github.com/rmosolgo/graphql-ruby/blob/bace1e4027900fc8779a5c2fd393ff6456046cea/lib/graphql/parse_error.rb
    render json: {
      errors: [{ message: e.message, extensions: { code: e.class.name.demodulize } }],
      data: {}
    }, status: 403
  rescue Pundit::Error => e
    render json: {
      errors: [{ message: e.message, extensions: { code: e.class.name.demodulize } }],
      data: {}
    }, status: 401
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  attr_accessor :current_user, :authentication_result

  def set_current_user
    @current_user =
      if warden.authenticate?(:jwt, scope: :user)
        warden.authenticate(:jwt, scope: :user)
      elsif warden.authenticate?(:jwt, scope: :authentication)
        authentication = warden.authenticate(:jwt, scope: :authentication)
        authentication.user
      end

    @authentication_result = warden.result
  end


  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
