class Users::AdminsController < Devise::RegistrationsController
  before_action :find
  before_action :authenticate_user!
  before_action :is_admin?
  def add_to_admins
    if @user.is_admin = true
      render json: {message: "#{@user.email} is admin"}
    else
      render json: {errors: @user.errors.full_messages}
    end
  end

  def remove_from_admins
    if @user.is_admin = false
      render json: {message: "#{@user.email} is not admin"}
    else
      render json: {errors: @user.errors.full_messages}
    end
  end

  private

  def find
    @user = User.find(params[:id])
  end
end