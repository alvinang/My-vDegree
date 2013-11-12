class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid

  has_many :courses

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    @user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless @user
      @user = User.create(name:auth.extra.raw_info.name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
      )
    end
    @user
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    @user = User.where(:email => data["email"]).first

    unless @user
      @user = User.create(name: data["name"],
                          email: data["email"],
                          password: Devise.friendly_token[0,20]
      )
    end
    @user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    @user = User.where(provider: auth.provider, uid: auth.uid).first

    unless @user
      @user = User.create(name: auth.info.name,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20]
      )
    end
    @user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
