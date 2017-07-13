class Helper
  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    self.logged_in?(session) ? User.find_by_id(session[:user_id]) : nil
    end

    def self.redirect_if_not_logged_in
      if !self.logged_in?(session)
        redirect "/index"
      end
    end

end
