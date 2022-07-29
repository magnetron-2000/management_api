class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def check_access?
    if current_user.worker.id != @worker.id
      unless current_user.is_admin || current_user.worker.role == "Manager"
        render json: {message: "you have not access"}, status: 401
      end
    end
  end
  def is_admin?
    unless current_user.is_admin
      render json: {message: "you are not admin"}, status: 401
    end
  end

  def is_manager?
    unless current_user.worker.role == "Manager"
      render json: {message: "you are not manager"}
    end
  end

  protected
  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end
