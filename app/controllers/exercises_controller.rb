class ExercisesController < ApplicationController
  #index
  get '/exercises' do
    if Helper.logged_in?(session)
      @exercises = Exercises.all
      @user = Helper.current_user(session)
      erb:'/exercises'
    else
      redirect to "/login"
    end
  end

  #new
  get '/exercises/new' do
    if Helper.logged_in?(session)
      erb :'exercises/new'
    else
      redirect "/login"
    end
  end

  #create
  post '/exercises' do
    user = Helper.current_user(session)
  if params[:name].empty? || params[:repititons].empty? ||
     params[:sets].empty?
    @exercise= Exercises.create(name: params[:name], repititions:
    params[:repititions], sets: params[:sets])
    @exercise.user= user
    @exercise.save
  else
    redirect "exercises/new"
    end
    redirect("/exercises/#{exercise.id}")
  end

  get '/exercises/:id' do
    
  end

end
