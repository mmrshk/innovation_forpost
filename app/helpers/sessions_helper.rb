module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #Check if super_admin
  def super_admin?
    @current_user && @current_user.role == 'super_admin'
  end

  #Check if admin
  def admin?
    @current_user && @current_user.role == 'admin'
  end

  #returns true if the given user is current user
  def current_user?(user)
    user && user == current_user
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  #Stores the URL trying to be access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end


end
