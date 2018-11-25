class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render :json, status: 200
    else
      render json: { errors: "Couldn't save user correctly" }, status: 422
    end
  end

  def update
    @user = User.update(user_params)
    if @user.save
      render :json, status: 200
    else
      render json: { errors: "Couldn't save user correctly" }, status: 422
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: "User successfully destroyed" }, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation)
  end
end
