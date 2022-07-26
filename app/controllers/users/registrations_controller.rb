class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def sign_up_params

  end
  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    setup_worker
    render json: {
      message: 'Signed up sucessfully.',
      user: current_user,
      worker: worker
    }, status: :ok
  end

  def setup_worker
    Worker.create!(params.require(:data).permit(:first_name, :last_name, :age, :role, :user_id => current_user))
  end
  def register_failed
    render json: { message: 'Something went wrong.', errors: [worker.errors.full_messages] }, status: :unprocessable_entity
  end
end