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
    redirect_to login_url, error: "Please sign in." unless authenticate? #this is good except the erro doesn't seem to work
  end
end
