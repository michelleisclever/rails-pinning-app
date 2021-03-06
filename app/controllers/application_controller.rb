class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :exception
        before_action :require_login, only: [:show, :edit, :update, :destroy]

  def require_login
    if current_user.nil?
        redirect_to login_path
    end
   end

    def current_user
        @user ||= User.where("id=?", session[:user_id]).first
    end
    
    def logged_in?
        !current_user.nil? && !current_user.id.nil?
    end
    
    helper_method :current_user
    helper_method :logged_in?
end
