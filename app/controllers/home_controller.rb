class HomeController < ApplicationController
  def index
    if current_user.nil?
      render "index"
    else
      render "index_logged_in"
    end
  end
end
