class Users::AdminsController < Devise::RegistrationsController
  before_action :set_user
  before_action :authenticate_user!
  before_action :is_active?
  before_action :is_admin?
  before_action :is_user_manager?, only: [:add_to_admins]
  def add_to_admins
    if @user.check_admin
      render json: {errors: "already admin!"}
    else
      @user.adding
      if @user.saving
        render json: {message: "#{@user.email} is admin"}
      else
        render json: {errors: "something went wrong"}
      end
    end
  end

  def remove_from_admins
    if not @user.check_admin
      render json: {errors: "already not an admin!"}
    else
      @user.removing
      if @user.saving
        render json: {message: "#{@user.email} is not admin"}
      else
        render json: {errors: "something went wrong"}
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def is_user_manager?
    unless @user.check_manager
      render json: {error: "user is not manager!"}
    end
  end
end