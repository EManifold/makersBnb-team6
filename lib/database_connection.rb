require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  def self.start
    if ENV['RACK_ENV'] == 'test'
      DatabaseConnection.setup("makersbnb_test")
    else
      DatabaseConnection.setup("makersbnb")
    end
  end
end
