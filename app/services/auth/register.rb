module Auth
  class Register
    def initialize(email, password, confirmation)
      @email = email
      @password = password
      @password_confirmation = confirmation
    end

    def execute
      User.create!(
        email: @email,
        password: @password,
        password_confirmation: @password_confirmation
      )
    end
  end
end
