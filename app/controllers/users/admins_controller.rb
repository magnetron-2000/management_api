class Users::AdminsController < Devise::RegistrationsController
  before_action :find
  before_action :authenticate_user!
  before_action :is_admin?
  def add_to_admins
    if @user.is_admin == true
      render json: {errors: "already admin!"}
    else
      @user.is_admin = true
      if @user.save
        render json: {message: "#{@user.email} is admin"}
      else
        render json: {errors: "something went wrong"}
      end
    end
  end

  def remove_from_admins
    if @user.is_admin == false
      render json: {errors: "already not an admin!"}
    else
      @user.is_admin = false
      if @user.save
        render json: {message: "#{@user.email} is not admin"}
      else
        render json: {errors: "something went wrong"}
      end
    end
  end

  private

  def find
    @user = User.find(params[:id])
  end
end