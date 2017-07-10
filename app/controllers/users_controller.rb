class UsersController < ApplicationController

  get '/signup' do
    if Helper.logged_in?(session)
      redirect "/exercises"
    else
      erb :'users/new'
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect "/signup"
    else
      user= User.new(username: params[:username], password: params[:password])
      user.save
      session[:user_id]= user.id
      redirect to "/exercises"
  end
  
end
