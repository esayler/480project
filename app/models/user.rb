class User < ActiveRecord::Base

  has_many :problems
  has_many :attempts

  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true

  enum role: [:student, :alum, :prof, :admin]
  after_initialize :set_default_role, :if => :new_record?


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name # assuming the user model has a name
      user.password = Devise.friendly_token[0,20]
    end

  end

  
  def password_required?
    super && self.provider.blank?
  end


  def set_default_role
    self.role ||= :student
  end

  def get_attempts
    return self.attempts
  end

  def get_problems
    return self.problems
  end



  devise :database_authenticatable, :registerable,
        #:confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

end
