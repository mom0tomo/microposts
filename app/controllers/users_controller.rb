class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
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
  
  private

    def user_params
      paramas.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
