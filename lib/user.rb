require 'pg'
require 'bcrypt'
require_relative '../database_connection_setup'
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
    new_user = DatabaseConnection.query("INSERT INTO users(name, email, password, username) VALUES ('#{name}',
    '#{email}','#{encrypted_password}','#{username}') RETURNING name, username, email, id;")
    User.new(new_user[0]['name'], new_user[0]['username'], new_user[0]['email'], new_user[0]['id'])
  end

  def self.find(id)
    found_user = DatabaseConnection.query("SELECT name, username, email, id FROM users WHERE id = '#{id}';")
    User.new(found_user[0]['name'], found_user[0]['username'], found_user[0]['email'], found_user[0]['id'])
  end

  def self.login(email:, password: )
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any? && BCrypt::Password.new(result[0]['password']) == password
    User.find(result[0]['id'])
  end

end
