class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  has_many :providers, dependent: :destroy

  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :linkedin, :github]

  def self.create_from_omniauth(params, for_login)
    user = first_or_create(email: params.info.email)
    
    if for_login
      user.update({name: params.info.name,
                password: Devise.friendly_token[0,20],
                current_provider: params.provider
              }) 
    end

    user.providers.find_or_create_by({ provider: params.provider, uid: params.uid }).update({ oauth_token: params.credentials.token })
    user.skip_confirmation!
    user
  end
end
