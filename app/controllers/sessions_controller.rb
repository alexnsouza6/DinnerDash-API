class SessionsController < ApplicationController
  def create
    if user = User.valid_login?(params[:email], params[:password])
      token = generate_token(user)
      user.update_column(token: token)
      render json: user, status: 200
    else
      render json: { message: "Invalid E-mail or Password" }, status: 401
  end
end
