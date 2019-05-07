class SessionsController < ApplicationController
  def create
    auth_params = request.env["omniauth.auth"]
    user = User.from_omniauth(auth_params)
    UserMailer.with(user: user).access_request.deliver_later
    if user.can_access?(auth_params)
      session[:user_id] = user.id
      redirect_to events_path
    else
      flash[:notice] = I18n.t("failure")
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end