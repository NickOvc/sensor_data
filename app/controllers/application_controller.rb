class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    token_authentication || handle_wrong_authentication
  end

  def token_authentication
    authenticate_with_http_token do |token|
      token == ENV['SENSORS_API_TOKEN']
    end
  end

  def handle_wrong_authentication
    render json: { message: 'Wrong Credentials!' }, status: 403
  end

  def render_error(message, status)
    render json: { error: { message: } }, status:
  end
end
