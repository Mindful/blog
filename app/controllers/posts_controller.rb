class PostsController < ApplicationController

  before_action :require_login, except: [:home_index, :show] 

  def home_index
    #@posts = Post.where(:user_id => current_user.id).paginate(:page => params[:page]) for scoped queries
    @posts = Post.order("created_at DESC").paginate(:page => params[:page])
  end

  def admin_index #the html/erb for this may eventually be very similar to search results, just with more admin options
    @posts = Post.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.title = "Post title"
    @post.content_markdown = "Post body"
    render 'edit'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
    Post.find(params[:id]).destroy
    if request.referrer == admin_index_url
      render :js => "$(\"li[data-id='#{params[:id].to_s}']\").remove();"
      #TODO: alert that the thing has been deleted.
    else
      flash[:success] = "Post deleted."
      redirect_to root_url
    end
  end


  private

    def post_params #this is basically redundant because it permits all params, but I believe rails will error without it
      params.require(:post).permit(:title, :content_markdown, :content_html)
    end
end
