class UsersController < ApplicationController

  get '/signup' do
    if Helper.logged_in?(session)
      redirect "/exercises"
    else
      erb :'users/new'
    end
  end
#signup
  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect "/signup"
    else
      user= User.new(username: params[:username], password: params[:password])
      user.save
      session[:user_id]= user.id
      redirect "/exercises"
    end
  end

  get '/login' do
    if Helper.logged_in?(session)
      redirect "/exercises"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]= @user
      redirect "/exercises"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
