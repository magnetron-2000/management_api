class User < ApplicationRecord
  has_one :worker
  has_one :puppy
  has_many :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  #self.skip_session_storage = [:http_auth, :params_auth]

  accepts_nested_attributes_for :worker, :puppy, :books
end
