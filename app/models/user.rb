# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, presence: { message: "User name already taken" }
  validates :password_digest, length: { minimum: 6, allow_nil: true }
  validates :user_name, :session_token, uniqueness: true
  after_initialize :ensure_session_token

  attr_reader :password

  def ensure_session_token
    self.session_token ||= reset_session_token!
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil unless @user && @user.is_password?(password)
    @user
  end
end
