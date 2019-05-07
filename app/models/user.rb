class User < ActiveRecord::Base
  belongs_to :role, optional: true

  scope :admin_users, -> () {where(role_id: Role.where(name: "Super Admin"))}

  def self.from_omniauth(auth)
    role = Role.find_by(name: Role::NORMAL_USER)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
    user.role_id = role.id if user.role_id.nil?
    user.grant_login_access = false if user.grant_login_access.blank?
    user.active_status = false if user.active_status.blank?
    user.email = auth.info.email
    user.save!
    user
  end

  def can_access?(auth_params)
    auth_params[:extra][:raw_info][:hd] == "jifflenow.com" &&
    self.grant_login_access == true &&
    self.active_status == true
  end

  def self.search(search)
    self.where("name ILIKE ?","%#{search}%")
  end


  def admin?
    if self.role.present?
      self.role.name == "Super Admin"
    else
      false
    end
  end

  def css?
    if self.role.present?
    self.role.name == "L1"
    else
      false
    end
  end

   def cse?
    if self.role.present?
    self.role.name == "L2"
    else
      false
    end
  end

   def normal_user?
    if self.role.present?
    self.role.name == "Normal User"
    else
      false
    end
  end

  def infra?
    if self.role.present?
    self.role.name == "infra"
    else
      false
    end
  end

end
