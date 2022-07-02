class AdminsController < ApplicationController
  before_action :current_user
  before_action :authenticate_user!
  



  def users_show
    @user = current_user
    #@c_u = current_user
    #puts "#### c_u: #{@c_u.id}"

    if @user.role == 'super_admin'
      @users ||= User.all
    end
  end

  def articles_show
    @user = current_user
    #if super_admin? || admin?
      #@articles ||= Articles.all
    #end
  end

  # GET /users/1 or /users/1.json
  def show
    set_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.role = 'user'
    respond_to do |format|
      if @user.save
        if super_admin?
          path = admins_users_show_url
        else
          log_in @user
          path = user_url(@user)
        end
        format.html { redirect_to path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 

  # PATCH/PUT /users/1 or /users/1.json
  def update
    set_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      if super_admin?
        format.html { redirect_to admins_users_show_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash.now[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #Check users permitions to do with DB 
    def authorized_user?
      set_user
      unless current_user?(@user) || super_admin?
        respond_to do |format|
          format.html { redirect_to root_url, notice: "You have no permitions to do that!" }
          format.json { head :no_content }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :role, :password, :password_confirmation)
    end
end
