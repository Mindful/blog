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
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
