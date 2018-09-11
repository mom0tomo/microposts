class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ControllerでHelperのメソッドを利用する
  include SessionsHelper

  private

    def require_user_logged_in
      redirect_to login_url unless logged_in?
    end
    
    def counts(user)
       @count_microposts = user.feed_microposts.count
       @count_followings = user.followings.count
       @count_followers = user.followers.count
    end
end