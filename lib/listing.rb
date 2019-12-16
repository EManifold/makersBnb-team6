class Listing 

  def self.all
    if ENV['RACK_ENV'] = 'test'
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end
    rows = connection.exec('SELECT * FROM listings')
    rows.map do |listing|
      listing["address"]
    end

    
  end
end