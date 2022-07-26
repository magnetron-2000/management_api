class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  private

  def respond_with(resource, _opts = {})
    register_success(resource) && return if resource.persisted?

    register_failed
  end

  def register_success(resource)
    worker = Worker.new(params.require(:data).permit(:first_name, :last_name, :age, :role))

    if worker.save(:validate => false)
      @user = User.last
      @user.worker_id = worker.id
      @user.save

      render json: {
        message: 'Signed up sucessfully.',
        user: current_user,
        worker: worker
      }, status: :ok
    else
      render json: {errors: [worker.errors.full_messages]}, status: :expectation_failed
    end
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end