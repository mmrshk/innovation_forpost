module AdminsHelper
  
  #Check if super_admin
  def super_admin?
    @logged_in_user.role == 'super_admin'
  end

  #Check if admin
  def admin?
    @logged_in_user.role == 'admin'
  end






  #returns true if the given user is current user
  def current_user?(user)
    user && user == current_user
  end
  
 
  

  #Stores the URL trying to be access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  
end
