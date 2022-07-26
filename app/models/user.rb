class User < ApplicationRecord
  has_one :worker
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  #self.skip_session_storage = [:http_auth, :params_auth]
  accepts_nested_attributes_for :worker
end
