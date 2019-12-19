require 'sendgrid-ruby'
require_relative 'database_connection'
require 'pg'
include SendGrid

### add enviroment variable in consol by pasting this - export SENDGRID_API_KEY=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

class Email
  include SendGrid

  def self.register(id)
    DatabaseConnection.start
    user_email = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}'")
    from = SendGrid::Email.new(email: 'staff@makersbnb.com')
    to = SendGrid::Email.new(email: user_email[0]['email'])
    subject = 'Succesful registering'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Thank you for registering with makersbnb')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def self.booking_confirmation(id)
    DatabaseConnection.start
    user_email = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}'")
    from = SendGrid::Email.new(email: 'staff@makersbnb.com')
    to = SendGrid::Email.new(email: user_email[0]['email'])
    subject = 'Succesful booking'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Thank you for your holiday in a cave with makersbnb')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def self.listing_confirmation(id)
    DatabaseConnection.start
    user_email = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}'")
    from = SendGrid::Email.new(email: 'staff@makersbnb.com')
    to = SendGrid::Email.new(email: user_email[0]['email'])
    subject = 'Succesful listing!'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Thank you for your your listing')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
