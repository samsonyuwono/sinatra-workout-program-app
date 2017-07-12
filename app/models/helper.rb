class Helper

  def self.redirect_if_not_logged_in(session)
    if !logged_in(session)
      redirect "/login?error= You have to be logged in to do that"
    end
  end
  
  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    self.logged_in?(session) ? User.find_by_id(session[:user_id]) : nil
    end

end
