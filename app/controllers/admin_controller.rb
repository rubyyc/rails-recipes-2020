class AdminController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  # before_action :require_admin!

  layout "admin"

  protected

  def require_editor!
    # if current_user.role != "editor" && current_user.role != "admin"
    unless current_user.is_editor?
      flash[:alert] = "您的权限不足"
      redirect_to root_path
    end
  end

  def require_admin!
    # if current_user.role != "admin"
    unless current_user.is_admin?
      flash[:alert] = "您的权限不足"
      redirect_to root_path
    end
  end

end
