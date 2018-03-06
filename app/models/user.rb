class User < ActiveRecord::Base
  after_initialize :set_default_role, :if => :new_record?
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  
  devise :database_authenticatable,
  :registerable,
  :trackable, 
  :validatable,
  :confirmable,
  :omniauthable, omniauth_providers: [:facebook, :linkedin, :github]
  
  has_one :profile,  dependent: :destroy
  has_many :providers, dependent: :destroy
  accepts_nested_attributes_for :profile

  def set_default_role
    self.profile.role ||= :user
  end

  def profile
    super || build_profile
  end
  
  def self.create_from_omniauth(params, for_login)
    where(email: params.info.email).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
    
    user = find_by(email: params.info.email)

    if for_login
     user.profile.update({name: params.info.name, current_provider: params.provider})
    end 
    
    user.providers.find_or_create_by({ provider: params.provider, uid: params.uid }).update({ oauth_token: params.credentials.token })
    user
  end

  def create_subscription
    now = DateTime.now
    self.profile.update(subscribed_at: now, expired_at: now + 1.month)
  end

  def allow_user?
    self.subscribed? && !self.subscribtion_expired?
  end

  def subscribed?
    !self.profile.subscribed_at.nil?
  end
  
  def subscribtion_expired?
    DateTime.now >= self.profile.expired_at
  end
end
