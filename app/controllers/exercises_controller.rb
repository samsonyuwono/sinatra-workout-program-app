class ExercisesController < ApplicationController
  #index
  get '/exercises' do
    if Helper.logged_in?(session)
      @exercises = Exercises.all
      @user = Helper.current_user(session)
      erb :'/exercises/exercises'
    else
      redirect to "/login"
    end
  end

  #new
  get '/exercises/new' do
    if Helper.logged_in?(session)
      erb :'exercises/new'
    else
      redirect to "/login"
    end
  end

  #create
  post '/exercises' do
    @user = Helper.current_user(session)
    @exercise= Exercises.create(:name => params[:name], :repetition=>
    params[:repetition], :sets=> params[:sets])
    redirect("/exercises/#{@exercise.id}")
  end

#show
  get '/exercises/:id' do
    if Helper.logged_in?(session)
      @exercise= Exercises.find_by_id(params[:id])
      erb :'exercises/show'
    else
      redirect "/login"
    end
  end

#edit
  get "/exercises/:id/edit" do
    @exercise= Exercises.find_by_id(params[:id])
    erb :edit
  end

  patch '/exercises/:id' do
    @exercise= Exercises.find_by_id(params[:id])
    @exercise.name = params[:name]
    @exercise.repetition= params[:repetitions]
    @exercise.sets= params[:sets]
    @exercise.save
    redirect "/exercises/#{@exercise.id}"
  end

#delete
  delete '/exercises/:id/delete' do
    @exercise= Exercises.find_by_id(params[:id])
    @exercise.destroy
    redirect "/exercises"
  end

end
