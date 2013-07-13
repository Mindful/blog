class PostsController < ApplicationController

  before_action :require_login, except: [:home_index, :search_index, :show] 

  def home_index
    #@posts = Post.where(:user_id => current_user.id).paginate(:page => params[:page]) for scoped queries
    @posts = Post.paginate(:page => params[:page])
    @empty_msg = "It seems there are currently no posts."
  end

  def search_index
    if params.has_key? :search
      @posts = Post.search(params[:search]).paginate(:page => params[:page])
      @empty_msg = "Unfortunately, a search for \"#{params[:search]}\" has returned no results. Consider trying fewer keywords."
    elsif params.has_key? :tag
      @posts = Post.tagged_with(params[:tag], :on => :tags).paginate(:page => params[:page])
      @empty_msg = "Unfortunately, it seems \"#{params[:tag]}\" is not currently being used as a tag on any posts."
    elsif params.has_key? :category
      @posts = Post.tagged_with(params[:category], :on => :category).paginate(:page => params[:page])
      @empty_msg = "Unfortunately, it seems \"#{params[:category]}\" is not currently being used as a category for any posts."
    end
    @shorten_posts = true #maxchars 250
    render 'home_index'
  end

  def admin_index #the html/erb for this may eventually be very similar to search results, just with more admin options
    @posts = Post.all
  end

  def show
    @post = Post.find_by_url(params[:id])
  end

  def new
    @post = Post.new
    @post.set_defaults
    @edit_post = true
    @btn = "Post"
    @date = Time.now
    @date = @date.strftime("%B #{@date.day.ordinalize}, %Y")
    @title = "New Post"
    render 'edit'
  end

  def create
    @post = Post.new(create_post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to root_url
    else
      @edit_post = true
      @btn = "Post"
      @date = Time.now
      @date = @date.strftime("%B #{@date.day.ordinalize}, %Y")
      @title = "New Post"
      render 'edit'
    end
  end

  def edit
    @post = Post.find_by_url(params[:id])
    @edit_post = false
    @btn = "Update"
    @date = @post.created_at.to_s(:pretty)
    @title = "Edit Post"
  end

  def update
    @post = Post.find_by_url(params[:id]) #well this doesn't really work, given that the id is based on the title
    if @post.update_attributes(update_post_params)
      flash[:success] = "Post updated"
      redirect_to root_url #maybe we should redirect to the post itself?
    else
      render 'edit'
    end
  end

  def destroy
    Post.find_by_url(params[:id]).destroy
    if request.referrer == admin_index_url
      render :js => "$(\"li[data-url='#{params[:id].to_s}']\").remove();" #stringex's acts_as_url is making our id param into a url, so we look for that
      #TODO: alert that the thing has been deleted.
    else
      flash[:success] = "Post deleted"
      redirect_to root_url
    end
  end


  private

    def create_post_params #this is basically redundant because it permits all params, but I believe rails will error without it
      params.require(:post).permit(:title, :content_markdown, :content_html, :tag_list, :category_list)
    end

    def update_post_params
      params.require(:post).permit(:content_markdown, :content_html, :tag_list)
    end
end
