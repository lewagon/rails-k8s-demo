class LoginsController < ApplicationController
  skip_before_action :authenticate

  def new
    redirect_to messages_path if cookies.encrypted[:username].present?
  end

  def create
    if params[:username].present?
      cookies.encrypted[:username] = params[:username]
      redirect_to messages_path
    else
      redirect_to new_login_path, alert: "Username can't be blank" unless username
    end
  end

  def destroy
    cookies.encrypted[:username] = nil
    redirect_to new_login_path
  end
end
