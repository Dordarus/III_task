class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :linkedin]

  def self.create_from_omniauth(params)
   user = first_or_create(User.find_by(email: params.info.email))
   user.update({provider: params.provider,
                uid: params.uid,
                password: Devise.friendly_token[0,20],
                name: params.info.name
              })
                user.skip_confirmation!
                user
   end
end
