class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :email, presence: true, uniqueness: true, format: {with: /\b[&.+.A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}/, message: "Please enter a valid email address." }
  validates :username, presence: true, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
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
