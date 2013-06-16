class PostsController < ApplicationController

  before_action :require_login, except: [:index, :show] #everything except viewing requires that you be logged in --make sure "except" works, else use only


  def index
    #@posts = Post.where(:user_id => current_user.id).paginate(:page => params[:page]) for scoped queries
    @posts = Post.paginate(:page => params[:page]) 
    respond_to do |format| #is this necessary?
      format.html
      format.js #99% sure what this is doing is just fetching the index.js file
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted."
    #this redirect should eventually be smart enough to redirect to root_url on deletes via the _post partial and to the admin index when deletes are done like that
    #request.url here is always ending up being the post/its ID, so I'm not sure that will help us
    redirect_to root_url
  end
end
