require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include BCrypt

  field :email, type: String
  field :username, type: String
  field :password_hash, type: String

  index({ username: 1 }, { unique: true, name: "username_index" })

  has_many :rides

  validates :email, presence: true
  validates :username, presence: true
  validates :password_hash, presence: true
  validates :username, uniqueness: true

  class << self
    def oauth_authenticate(_client, username, password)
      user = find_by(username: username)
      return user if user && user.password == password
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    return unless new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
