class PostsController < ApplicationController

  before_action :require_login, except: [:home_index, :show] #everything except viewing requires that you be logged in --make sure "except" works, else use only


  def home_index
    #@posts = Post.where(:user_id => current_user.id).paginate(:page => params[:page]) for scoped queries
    @posts = Post.paginate(:page => params[:page])
  end

  def admin_index
    @posts = Post.all
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
    if request.referrer == admin_index_url
      redirect_to admin_index_path
    else
      redirect_to root_url
    end
  end
end
