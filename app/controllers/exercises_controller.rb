require 'sinatra/base'

class ExercisesController < ApplicationController
  enable :sessions

  get '/exercises' do
    authenticate_user!
    @exercises = current_user.exercises
    erb :'/exercises/exercises'
  end

  get '/exercises/new' do
    authenticate_user!
    erb :'exercises/new'
  end

  post '/exercises' do
    authenticate_user!
    @exercise = current_user.exercises.build(:name => params[:name], :repetition => params[:repetition], :sets => params[:sets], :weight => params[:weight], :notes => params[:notes])
    if @exercise.save
      flash[:message]= "Successfully created exercise!"
      redirect("/exercises/#{@exercise.id}")
    else
      flash[:message]= "Error: Something must be wrong, please try again."
      redirect '/exercises/new'
      end
  end

  get '/exercises/:id' do
    authenticate_user!
      @exercise = Exercise.find_by_id(params[:id])
      erb :'exercises/show'
  end

  get '/exercises/:id/edit' do
    authenticate_user!
    @exercise = current_user.exercises.find_by(id: params[:id])
    erb :'/exercises/edit'
  end

  patch '/exercises/:id' do
    authenticate_user!
    if @exercise = current_user.exercises.find_by(id: params[:id])
      if @exercise.update(:name => params[:name], :repetition => params[:repetition], :sets => params[:sets], :weight => params[:weight], :notes => params[:notes])
        flash[:message]= "Successfully edited exercise!"
        redirect "/exercises/#{@exercise.id}"
      else
        flash[:message] = @exercise.errors.full_messages.join(', ')
        erb :'/exercises/edit'
      end
    else
      flash[:message] = "You don't own that excercise"
      redirect "/exercises"
    end
  end

  delete '/exercises/:id/delete' do
    authenticate_user!
    if @exercise = current_user.exercises.find_by(id: params[:id])
      @exercise.delete
      flash[:message]= "Sucessfully deleted exercise!"
      redirect to "/exercises"
    else
      flash[:message]= "You can't do that. That exercise does not belong to you."
      redirect "/exercises"
      end
    end
  end
