class StaffController < ApplicationController
  #before_filter :confirm_logged_in,  :except => [:register, :attempt_login, :logout ]

  def login
    #login form
  end

  def register
    username = params[:username]
    if Staff.find_by_username(username)
      redirect_to(:action => "register")
      logger.warn "User with this name exist"
    else
      user = Staff.new
      user.username =  username
      user.password =  params[:password]
      logger.warn "Try to save"
      if user.save
        logger.warn "Succes saved"
        save_to_session(user.id, user.username)
        redirect_to(:controller => "tickets", :action => "index")
      end
    end
  end


  def logout
    #reset
    save_to_session(nil,nil)

    logger.warn "You have been logged out."
    redirect_to(:action => "login")
  end


  def attempt_login
    authorized_user = Staff.authenticate(params[:username],
                                         params[:password])

    if authorized_user
      save_to_session(authorized_user.id,authorized_user.username)

      logger.warn "You are now logged in. "
      redirect_to(:controller => "tickets", :action => "index")
    else
      logger.warn "Invalid username/password combination"
      redirect_to(:action => "login")
    end
  end
  private

  #Session
  def save_to_session(user_id, username)
    session[:user_id] = user_id
    session[:username] = username
  end
end
