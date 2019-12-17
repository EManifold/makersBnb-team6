require 'pg'
require 'bcrypt'

class User
  attr_reader :name, :username, :email, :id
  def initialize(name, username, email, id)
    @name = name
    @username = username
    @email = email
    @id = id
  end

  def self.create(name:, username:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    if ENV['RACK_ENV'] == 'test'
      user_data = PG.connect(dbname: 'makersbnb_test')
    else
      user_data = PG.connect(dbname: 'makersbnb')
    end
    new_user = user_data.exec("INSERT INTO users(name, email, password, username) VALUES ('#{name}',
    '#{email}','#{encrypted_password}','#{username}') RETURNING name, username, email, id;")
    User.new(new_user[0]['name'], new_user[0]['username'], new_user[0]['email'], new_user[0]['id'])
  end

  def self.find(id)
    if ENV['RACK_ENV'] == 'test'
      user_data = PG.connect(dbname: 'makersbnb_test')
    else
      user_data = PG.connect(dbname: 'makersbnb')
    end
    found_user = user_data.exec("SELECT name, username, email, id FROM users WHERE id = '#{id}';")
    User.new(found_user[0]['name'], found_user[0]['username'], found_user[0]['email'], found_user[0]['id'])
  end

  def self.login(email:, password: )
    if ENV['RACK_ENV'] == 'test'
      user_data = PG.connect(dbname: 'makersbnb_test')
    else
      user_data = PG.connect(dbname: 'makersbnb')
    end
    result = user_data.exec("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any? && BCrypt::Password.new(result[0]['password']) == password
    User.find(result[0]['id'])
  end

end
