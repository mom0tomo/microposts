class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    redirect_to root_url
  end

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like(micropost)
    flash[:success] = '投稿をlikeしました。'
    redirect_to micropost
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    flash[:success] = '投稿のlikeを解除しました。'
    redirect_to micropost
  end
end
