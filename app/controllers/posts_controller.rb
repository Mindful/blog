class PostsController < ApplicationController

  before_action :require_login, except: [:index, :show] #everything except viewing requires that you be logged in --make sure "except" works, else use only


  def index
    @posts = Post.all
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
