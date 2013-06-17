class PostsController < ApplicationController

  before_action :require_login, except: [:home_index, :show] 

  def home_index
    #@posts = Post.where(:user_id => current_user.id).paginate(:page => params[:page]) for scoped queries
    @posts = Post.paginate(:page => params[:page])
  end

  def admin_index #the html/erb for this may eventually be very similar to search results, just with more admin options
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
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
      redirect_to admin_index_path #EVENTUAL TODO: send an ajax/remote request from the admin_index, delete the post, and use javascript to remove it without ever reloading the page
    else
      redirect_to root_url
    end
  end
end
