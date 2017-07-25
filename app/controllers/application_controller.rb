require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "password_security"
    use Rack::Flash, sweep: true
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      # Memoization
      @current_user ||= User.find(id: session[:user_id])
    end

    def authenticate_user!
      redirect to "/login" if !logged_in?
    end
  end

end
