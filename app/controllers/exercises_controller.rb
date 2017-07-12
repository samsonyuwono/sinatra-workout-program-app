class ExercisesController < ApplicationController
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
      redirect("/exercises/#{@exercise.id}")
    else
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

#edit
  get '/exercises/:id/edit' do
    @exercise= Exercise.find_by_id(params[:id])
    erb :'/exercises/edit'
  end

  patch '/exercises/:id' do
    @exercise= Exercise.find_by_id(params[:id])
    @exercise.name = params[:name]
    @exercise.repetition= params[:repetition]
    @exercise.sets= params[:sets]
    @exercise.save
    redirect to "/exercises/#{@exercise.id}/edit"
  end

#delete
  delete '/exercises/:id/delete' do
  @exercise = Exercise.find_by_id(params[:id])
  if @user.exercises == Helper.current_user(session)
     @user.exercises.delete
     binding.pry
  else
     redirect "/login"
  end
end

end
