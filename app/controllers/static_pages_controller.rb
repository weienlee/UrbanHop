class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    @location = Location.new
    @action = @location.actions.build()
    @actions = Action.paginate(page: params[:page])
  end
  
  def about
  end
end
