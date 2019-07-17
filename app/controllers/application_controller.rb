require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index, layout: :layout
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def all_users
      User.all
    end
  end
end
