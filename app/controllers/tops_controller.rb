class TopsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @user = current_user
    @micropost = current_user.microposts.build
    @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
  end
end
