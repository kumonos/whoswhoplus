module SignInMacros
  def fake_signed_in(profile)
    session[:current_user] = profile.try(:id)
  end
end
