class User < ActiveRecord::Base
  attr_accessor :raw_password
  has_many :urls
  validates :email, format: {with: /\b[&.+.A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}/, message: "Please enter a valid email address." }
  validates_presence_of :username, :message => 'You need a username to create an account.'
  validates_presence_of :email, :message => 'You need an email to create an account.'
  validates_uniqueness_of :username, :message => 'This username has already been taken.'
  validates_uniqueness_of :email, :message => 'This email address has already been taken.'
  validates_length_of :raw_password, :minimum => 5, :message => "Your password isn't long enough. A password must contain at least 5 characters."

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
    self.raw_password = new_password
  end


  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    if @user && @user.password == password
      return @user
    else
      return nil
    end
  end
end
