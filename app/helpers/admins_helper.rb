module AdminsHelper
  
  def super_admin?
    @logged_in_user.role == 'super_admin'
  end

  def admin?
    @logged_in_user.role == 'admin'
  end

  def last_super_admin?
    super_admin_count = 0
    @users ||= User.all
    @users.map { |user|
      super_admin_count += 1 if user.role == 'super_admin'
    }
    true if super_admin_count < 2
  end

  #returns true if the given user is current user
  def current_user?(user)
    user && user == current_user
  end

end
