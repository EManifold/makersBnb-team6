class Listing

  attr_reader :title, :address, :description, :price

  def initialize(title:, address:, description:, price:)
    @title = title
    @address = address
    @description = description
    @price = price
  end

  def self.all
    if ENV['RACK_ENV'] = 'test'
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end
    rows = connection.exec('SELECT * FROM listings')
    rows.map do |listing|
      Listing.new(title: listing['title'], address: listing['address'], description: listing['description'], price: listing['price'])
    end
  end

  def self.create(title:, address:, description:, price:)
    if ENV['RACK_ENV'] = 'test'
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end

    result = connection.exec("INSERT INTO listings(address, description, price, title) VALUES('#{address}', '#{description}', '#{price}', '#{title}') RETURNING address, description, price, title;")
    Listing.new(title: result[0]['title'], address: result[0]['address'], description: result[0]['description'], price: result[0]['price'])
  end

end
