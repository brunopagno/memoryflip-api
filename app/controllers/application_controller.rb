class ApplicationController < ActionController::API
  before_action :current_user

  def cookies
    request.cookie_jar
  end

  def current_user
    @current_user ||= Session.find_by('token = ? and expires_at > ?', auth_token, Time.zone.now).try(:user)
  end

  def auth_token
    @auth_token ||= cookies.signed[Session::COOKIE_NAME]
  end

  def authenticate
    head :unauthorized if current_user.blank?
  end
end
