module Auth
  class Login
    def initialize(email, password)
      @email = email
      @password = password
    end

    def execute
      user = User.find_by(email: @email)
      return unless user&.authenticate(@password)

      user.sessions.create!(
        token: SecureRandom.uuid,
        expires_at: Session::EXPIRE_TIME.from_now
      )
    end
  end
end
