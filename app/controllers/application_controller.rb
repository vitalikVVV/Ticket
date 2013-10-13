class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def confirm_logged_in
    unless session[:user_id]
      logger.warn "Please log in"
      redirect_to(:controller => "staff", :action => "login")
      return false #halts the before_filter
    else
      return true
    end
  end
end
