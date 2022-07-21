class ApplicationController < ActionController::Base
  include Pundit::Authorization

  skip_before_action :verify_authenticity_token
end
