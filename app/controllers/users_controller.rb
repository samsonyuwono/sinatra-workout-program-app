require 'sinatra/base'

class UsersController < ApplicationController
  enable :sessions

  get '/signup' do
    if logged_in?
      redirect "/exercises"
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      flash[:message]= "Oops, something must have went wrong"
      redirect "users/new"
    else
      user= User.new(username: params[:username], password: params[:password])
      user.save
      session[:user_id] = user.id
      flash[:message] = "You have successfully created a new account!"
      redirect "/exercises"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/exercises"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message]= "You have successfully logged in!"
      redirect "/exercises"
    else
      flash[:message]= "Error: Username and Password don't match."
      redirect to "/login"
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      flash[:message]= "You have successfully logged out!"
      erb :'users/login'
    else
      redirect to '/'
    end
  end

end
