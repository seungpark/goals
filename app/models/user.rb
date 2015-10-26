class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :generate_session_token

  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }


  has_many :goals

  has_many(
    :received_user_comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "UserComment"
  )

  has_many(
    :written_user_comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "UserComment"
  )

  has_many(
    :goal_comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "GoalComment"
  )


  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user.nil?
      nil
    else
      user.is_password?(password) ? user : nil
    end
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end



end
