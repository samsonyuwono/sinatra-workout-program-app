class ExercisesController < ApplicationController
  get '/exercises' do
    if Helper.logged_in?(session)
      @exercises = Exercises.all
      @user = Helper.current_user(session)
      erb:'/exercises'
    else
      redirect to "/login"
    end
  end

end
