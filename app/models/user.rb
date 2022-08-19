class User < ApplicationRecord
  has_one :worker
  validates :email, presence:true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  #self.skip_session_storage = [:http_auth, :params_auth]
  accepts_nested_attributes_for :worker


  def check_admin
    is_admin
  end

  def adding
    self.is_admin = true
  end

  def removing
    self.is_admin = false
  end
  def saving
    save
  end

  def check_manager
    self.worker.role == "Manager"
  end

  def mail_after_create
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
