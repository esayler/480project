class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google]
  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true

  def self.create_with_omniauth(auth)
    @user = nil
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        #user.avatar = auth['info']['image']
      end
      @user = user
    end
    return @user
  end

end
