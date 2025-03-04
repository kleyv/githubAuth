class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :rememberable, :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.github_username = auth.info.nickname
      user.github_avatar_url = auth.info.image
      user.github_token = auth.credentials.token
    end
  end

  # Override Devise's password required method
  def password_required?
    false
  end
end
