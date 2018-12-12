class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.token = generate_token(@user)
    if @user.save
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    render json: { message: "User successfully destroyed" }, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                  :password_confirmation, :token)
  end
end
