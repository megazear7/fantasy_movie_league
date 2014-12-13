class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  private

    def require_login
      if not current_user and not params[:controller].include? "devise"
        redirect_to new_user_session_path
      end
    end

end
