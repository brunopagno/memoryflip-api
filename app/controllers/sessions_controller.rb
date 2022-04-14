class SessionsController < ApplicationController
  def create
    Auth::Logout.new(auth_token).execute if auth_token

    email = params.fetch(:email)
    password = params.fetch(:password)
    session = Auth::Login.new(email, password).execute

    if session
      create_cookies!(session.token)
      head :ok
    else
      head :unauthorized
    end
  end

  def destroy
    if current_user
      Auth::Logout.new(auth_token).execute
      destroy_cookies!
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def create_cookies!(token)
    expire_time = Session::EXPIRE_TIME.from_now

    cookies.signed[Session::COOKIE_NAME] = {
      value: token,
      path: '/',
      httponly: true,
      secure: true,
      expires: expire_time,
      same_site: :none
    }
    cookies[Session::LOGIN_COOKIE_NAME] = {
      value: 'true',
      path: '/',
      httponly: false,
      secure: true,
      expires: expire_time,
      same_site: :none
    }
  end

  def destroy_cookies!
    cookies.delete(Session::COOKIE_NAME)
    cookies.delete(Session::LOGIN_COOKIE_NAME)
  end
end
