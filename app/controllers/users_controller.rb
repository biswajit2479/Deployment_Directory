class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update]

  def index
    user_scope = User.includes(:role)
    user_scope = user_scope.search(params[:search]) if params[:search]
    @users = user_scope

    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User role was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:role_id, :grant_login_access, :active_status)
    end

end
