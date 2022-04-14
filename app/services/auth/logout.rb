module Auth
  class Logout
    def initialize(token)
      @token = token
    end

    def execute
      session = Session.find_by(token: @token)
      session&.destroy!
    end
  end
end
