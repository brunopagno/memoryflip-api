class ApplicationController < ActionController::API
  before_action :current_user

  def current_user
    @current_user ||= session.try(:user)
  end

  def session_token
    @session_token ||= request.headers[Session::TOKEN_NAME]
  end

  def authenticate
    head :unauthorized if current_user.blank?
  end

  private

  def session
    session = Session.find_by(token: session_token)
    if session && session.expires_at < Time.zone.now
      render json: { error: Session::TOKEN_EXPIRED }, status: :unauthorized
    end
    session
  end
end
