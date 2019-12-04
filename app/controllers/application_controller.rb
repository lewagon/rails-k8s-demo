class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    if (username = cookies.encrypted[:username].presence)
      Current.username = username
    else
      redirect_to new_login_path
    end
  end
end
