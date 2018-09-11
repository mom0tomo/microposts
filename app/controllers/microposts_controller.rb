class MicropostsController < ApplicationController
  before_action :require_user_logged_in

  def index
    redirect_to root_url
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tops/index'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url unless @micropost
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
