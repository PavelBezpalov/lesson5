module AuthenticationHelpers
  def sign_in(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end