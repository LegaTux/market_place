require 'pry'
class Api::V1::UsersController < Api::V1::BaseController

  def index
    respond_with User.all
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    if User.exists?(params[:id])
      User.destroy(params[:id])
      head 204
    else
      head 404
    end
  end

  private

  def user_params
    params.require(:user).permit( :id, 
                                  :name, 
                                  :email, 
                                  :password, 
                                  :password_confirmation
                                )
  end
end
