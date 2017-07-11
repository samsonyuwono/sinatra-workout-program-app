class UsersController < ApplicationController

  get '/signup' do
    if Helper.logged_in?(session)
      redirect to "/exercises"
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? ||
       params[:email].empty?
      redirect "/signup"
    else
      user= User.new(username: params[:username], password: params[:password],
      email: params[:email])
      user.save
      session[:user_id]= user.id
      redirect to "/exercises"
    end
  end

  get '/login' do
    if Helper.logged_in?(session)
      redirect to "/excercises"
    else
      erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]= @user
      redirect to "/exercises"
    else
      redirect to "/login"
    end
  end

end
