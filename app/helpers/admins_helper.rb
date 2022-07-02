module AdminsHelper
  
  def super_admin?
    @logged_in_user.role == 'super_admin'
  end

  def admin?
    @logged_in_user.role == 'admin'
  end

  #returns true if the given user is current user
  def current_user?(user)
    user && user == current_user
  end

end
