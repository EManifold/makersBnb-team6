class Listing

  attr_reader :owner_id, :title, :address, :description, :price

  def initialize(owner_id:, title:, address:, description:, price:)
    @owner_id = owner_id
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
      Listing.new(owner_id: listing['owner_id'], title: listing['title'], address: listing['address'], description: listing['description'], price: listing['price'])
    end
  end

  def self.create(owner_id:, title:, address:, description:, price:)
    if ENV['RACK_ENV'] = 'test'
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end

    result = connection.exec("INSERT INTO listings(owner_id, address, description, price, title) VALUES('#{owner_id}', '#{address}', '#{description}', '#{price}', '#{title}') RETURNING owner_id, address, description, price, title;")
    Listing.new(owner_id: result[0]['owner_id'], title: result[0]['title'], address: result[0]['address'], description: result[0]['description'], price: result[0]['price'])
  end

end
