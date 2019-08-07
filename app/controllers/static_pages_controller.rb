class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = Micropost.feed(current_user.id).order_by_created_at.paginate(page: params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end
end
