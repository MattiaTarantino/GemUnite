class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_and_belongs_to_many :fields
  has_many :user_projects, dependent: :destroy
  has_many :chats
  has_many :projects, through: :user_projects

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates_presence_of :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:github]

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "firstname", "id", "lastname", "provider", "reset_password_sent_at", "reset_password_token", "uid", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["fields", "projects", "reports", "requests", "user_projects", "chats"]
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if params[:password].blank? || valid_password?(current_password)
               update(params, *options)
             else
               self.assign_attributes(params, *options)
               self.valid?
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               false
             end

    clean_up_passwords
    result
  end
end
