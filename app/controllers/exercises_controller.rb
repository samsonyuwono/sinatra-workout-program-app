require 'sinatra/base'
require 'rack-flash'

class ExercisesController < ApplicationController
  enable :sessions
  use Rack::Flash
  #index
  get '/exercises' do

  if Helper.logged_in?(session)
    @user = Helper.current_user(session)
    @exercises = @user.exercises
    erb :'/exercises/exercises'
  else
    redirect to "/login"
  end
end

  #new
  get '/exercises/new' do
    if Helper.logged_in?(session)
      @user= Helper.current_user(session)
      erb :'exercises/new'
    else
      redirect to "/login"
    end
  end

  #create
  post '/exercises' do
    @user = Helper.current_user(session)
    @exercise = @user.exercises.build(:name => params[:name], :repetition=>
    params[:repetition], :sets=> params[:sets])
    if @exercise.save
      flash[:message]= "Successfully created exercise!" #working
      redirect("/exercises/#{@exercise.id}")
    else
      flash[:message]= "Error: Something must be wrong, please try again." #working
      redirect '/exercises/new'
    end
  end

#show
  get '/exercises/:id' do
    if Helper.logged_in?(session)
      @exercise= Exercise.find_by_id(params[:id])
      erb :'exercises/show'
    else
      redirect "/login"
    end
  end

#edit can edit everything
  get '/exercises/:id/edit' do
    if Helper.logged_in?(session)
      @user= session[:user_id]
      @exercise= Exercise.find_by_id(params[:id])
      erb :'/exercises/edit'
    else
      redirect "/"
    end
  end

  patch '/exercises/:id' do
    if Helper.current_user(session).id= session[:user_id]
      @exercise= Exercise.find_by_id(params[:id])
      @exercise.name = params[:name]
      @exercise.repetition= params[:repetition]
      @exercise.sets= params[:sets]
      @exercise.save
      flash[:message]= "Successfully edited exercise!" #working
      redirect "/exercises/#{@exercise.id}"
    else
      redirect "/exercises"
    end
  end

#delete- can delete everything
  delete '/exercises/:id/delete' do
    @user = Helper.current_user(session)
    if session[:user_id]== Helper.current_user(session)
    @exercise = Exercise.find_by_id(params[:id])
    @exercise.delete
      flash[:message]= "Sucessfully deleted exercise!" #working
      redirect to "/exercises"
    else
      redirect "/login"
   end
 end

end
