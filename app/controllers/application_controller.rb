class ApplicationController < ActionController::Base
  before_action :authenticate_user!


  protected
  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end
