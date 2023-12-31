class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_and_belongs_to_many :fields
  before_destroy :delete_projects_with_leader_role

  has_many :user_projects, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :projects, through: :user_projects

  validates :username, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates_presence_of :email
  validate :password_complexity
  validate :custom_validations

  def delete_projects_with_leader_role
    # Trova tutte le istanze di UserProject dell'utente con 'role' uguale a 'leader'
    user_projects_to_delete = user_projects.where(user_id: self.id, role: 'leader')

    # Estrai gli ID dei progetti associati a queste istanze di UserProject
    project_ids_to_delete = user_projects_to_delete.pluck(:project_id)

    # Elimina tutti i progetti con gli ID trovati
    Project.where(id: project_ids_to_delete).destroy_all
  end
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
      errors.add :password, "deve includere almeno una lettera minuscola, una maiuscola e un numero"
    end
  end

  def custom_validations
    pattern = /\A[a-zA-Z]+\z/
    if firstname.present? and not firstname.match(pattern)
      errors.add :firstname, "deve contenere solo lettere"
    end
    if lastname.present? and not lastname.match(pattern)
      errors.add :lastname, "deve contenere solo lettere"
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:github]

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "firstname", "id", "lastname", "provider", "reset_password_sent_at", "reset_password_token", "uid", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["fields", "projects", "reports", "requests", "user_projects", "messages"]
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
