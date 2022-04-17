class ApplicationController < ActionController::API
  before_action :current_user

  def current_user
    @current_user ||= Session.find_by('token = ? and expires_at > ?', session_token, Time.zone.now).try(:user)
  end

  def session_token
    @session_token ||= request.headers[Session::TOKEN_NAME]
  end

  def authenticate
    head :unauthorized if current_user.blank?
  end
end
