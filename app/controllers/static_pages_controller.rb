class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def gallery
  end

  def map
  end

  def jet
  end

  def admin
    redirect_to(root_path) unless authenticate?
  end
end
