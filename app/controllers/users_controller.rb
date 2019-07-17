class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :index, layout: :layout
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user.save
      session[:user_id] = @user.id
      redirect '/'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    end
    erb :index, layout: :layout
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    end
    redirect '/login'
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show', layout: :layout
  end

  get '/show' do
    if logged_in?
      @user = User.find_by(:username => params[:username])
      erb :'users/show', layout: :layout
    else
      redirect to '/'
    end
  end

end
