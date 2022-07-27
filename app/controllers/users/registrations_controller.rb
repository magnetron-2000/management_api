class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def worker_params
    params.require(:worker).permit(:first_name, :last_name, :role, :active, :age)
  end

  protected

  def build_resource(hash = nil)
    @user = User.new(user_params)
    @user.build_worker(worker_params)
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource)
  end

  def register_success
    render json: {
      message: 'Signed up sucessfully.',
      user: current_user,
      worker: current_user.worker
    }, status: :ok
  end

  def register_failed(resource)
    render json: { message: 'Something went wrong.', errors: [resource.errors.full_messages] }, status: :unprocessable_entity
  end
end