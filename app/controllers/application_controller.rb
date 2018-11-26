class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def current_user
    @current_user ||= authenticate_token
  end

  protected

  def generate_token(user)
    secret = 'Dinnerdash-token-auth'
    payload = { data: user.email + Time.new.to_s }
    token = JWT.encode payload,
                       secret,
                       'HS256'
    token
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by_token(token)
    end
  end
end
