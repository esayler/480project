class User < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        #user.avatar = auth['info']['image']
      end
    end
  end

end
