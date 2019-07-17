class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      @posts = Post.all
      erb :'posts/posts', layout: :layout
    else
      redirect '/'
    end
  end

  get '/posts/new' do
    if logged_in?
      erb :'posts/new', layout: :layout
    else
      redirect '/'
    end
  end

  post '/posts' do
    if logged_in?
      if params[:name] !="" && params[:ingredients] !="" && params[:directions] !="" && params[:cooktime] !="" && params[:chef] !="" && params[:caption] !=""
        @post = Post.new(name: params[:name], ingredients: params[:ingredients], directions: params[:directions], cooktime: params[:cooktime], chef: params[:chef], caption: params[:caption])
        @post.user = current_user
        @post.save

        redirect "/posts/#{@post.id}"
      else
        redirect '/posts/new'
      end
    else
      redirect '/'
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      erb :'users/show', layout: :layout
    else
      redirect to '/posts'
    end
    redirect to '/'
  end

  get '/posts/:id/edit' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post && @post.user == current_user
        erb :'/posts/edit_post', layout: :layout
      else
        redirect '/posts'
      end
    else
      redirect '/'
    end
  end

  patch '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if params[:name] !="" && params[:ingredients] !="" && params[:directions] !="" && params[:cooktime] !="" && params[:chef] !="" && params[:caption] !=""
        @post.update(name: params[:name], ingredients: params[:ingredients], directions: params[:directions], cooktime: params[:cooktime], chef: params[:chef], caption: params[:caption])
        erb :'posts/show_post', layout: :layout
      else
        redirect "/posts/#{@post.id}/edit"
      end
    else
      redirect '/'
    end
  end

  delete '/posts/:id/delete' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user == current_user
        @post.destroy
        redirect '/users/:slug'
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

end
