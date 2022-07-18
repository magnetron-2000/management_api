class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: {
      message: 'You are logged in.',
      user: current_user
    }, status: :ok
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?
    render json: { message: 'Finish.' }
    # render json: { message: 'You are logged out.' }, status: :ok && return if current_user # TODO bug current_user =nil
    # render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end