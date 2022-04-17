class UsersController < ApplicationController
  before_action :authenticate, except: %i[create]

  def create
    email = params.fetch(:email)
    password = params.fetch(:password)
    password_confirmation = params.fetch(:password_confirmation)

    user = Auth::Register.new(email, password, password_confirmation).execute

    if user
      session = Auth::Login.new(email, password).execute
      render json: { token: session.token }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      head :ok
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
