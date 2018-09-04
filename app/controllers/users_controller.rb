class UsersController < ApplicationController
  def index
    require_user_logged_in
    @users = User.all.page(params[:page])
  end

  def show
    require_user_logged_in
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ登録に失敗しました。'
      redirect_to :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  private

    def user_params
      paramas.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
