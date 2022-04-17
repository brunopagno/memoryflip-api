class SessionsController < ApplicationController
  def create
    Auth::Logout.new(session_token).execute if session_token

    email = params.fetch(:email)
    password = params.fetch(:password)
    session = Auth::Login.new(email, password).execute

    if session
      render json: { token: session.token }, status: :created
    else
      head :unauthorized
    end
  end

  def destroy
    if current_user
      Auth::Logout.new(session_token).execute
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
