require 'pg'
require 'bcrypt'

class User
  attr_reader :name, :username, :email, :password
  def initialize(name, username, email, password)
    @name = name
    @username = username
    @email = email
    @password = password
  end

  def self.create(name:, username:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    if ENV['RACK_ENV'] == 'test'
      user_data = PG.connect(dbname: 'makersbnb_test')
    else
      user_data = PG.connect(dbname: 'makersbnb')
    end
    new_user = user_data.exec("INSERT INTO users(name, email, password, username) VALUES ('#{name}','#{email}','#{encrypted_password}','#{username}') RETURNING name, username, email, password;")
    User.new(new_user[0]['name'], new_user[0]['username'], new_user[0]['email'], new_user[0]['password'])
  end

end
