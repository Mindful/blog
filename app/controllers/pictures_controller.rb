class PicturesController < ApplicationController


  SELECT_SLICE = 3

  def self.select_slice
    SELECT_SLICE
  end

  before_action :require_login, except: [:index]

  def new
  	@picture = Picture.new
  end

  def create
  	@picture = Picture.new(create_picture_params)
    if @picture.save
      flash[:success] = "Picture saved"
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def index
  	@picture = Picture.first
  end

  def medium
    render json: Picture.all.map {|p| p.image.url(:medium, timestamp: false)}.each_slice(PicturesController.select_slice)
  end

  def large
    render json: Picture.all.map {|p| p.image.url(:large, timestamp: false)}.each_slice(PicturesController.select_slice)
  end

  def thumb
    render json: Picture.all.map {|p| p.image.url(:thumb, timestamp: false)}.each_slice(PicturesController.select_slice)
  end

  def name
    render json: Picture.all.map {|p| p.name}.each_slice(PicturesController.select_slice)
  end

  private
    def create_picture_params
    	 params.require(:picture).permit! #permit all
    end
end
