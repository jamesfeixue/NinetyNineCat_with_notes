class User
  validates :user_name, :password_digest, presence: true

  after_initialize :ensure_session_token


  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save! #why not self.session_token.save! I'm guessing you can't call save on session_token
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password) #pretty much extending BCrypt's built in is_password
    # @password = password hmm why is there no @password here???
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(:user_name, user_name)

    return nil if user.nil?

    user.is_password?(password) ? user || nil

end
