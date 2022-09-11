class ApplicationController < ActionController::Base
  include Pundit::Authorization
  skip_before_action :verify_authenticity_token


  def is_admin?
    unless current_user.is_admin
      render json: {message: "you are not admin"}, status: 401
    end
  end

  def check_update_time
    unless @comment.check_time 6
      render json: {errors: "time for updating expired"}, status: 410
    end
  end

  def check_delete_time
    unless @comment.check_time 1
      render json: {errors: "time for deleting expired"}, status: 410
    end
  end

  def check_access_worker?
    check_access? @worker.id
  end

  def check_access_ticket?
    check_access? @ticket.creator_worker_id
  end

  def check_access_comment?
    unless current_user.worker.id == @comment.worker_id
      render json: {errors: "you have not access to delete this comment!"}
    end
  end

  def check_access?(table)
    if current_user.worker.id != table
      check_is_not_admin_or_manager?
    end
  end

  def check_is_not_admin_or_manager?
    unless current_user.is_admin || current_user.worker.role == "Manager"
      render json: {message: "you have not access, you are not admin or manager"}, status: 401
    end
  end

  def is_manager?
    current_user.worker.role == "Manager"
  end

  def current_worker
    current_user.worker
  end

  protected
  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end

  private

  def is_active?
    unless current_user.worker.active
      render json: {error: "deactivated workers can't get access!"}
    end
  end
end
