require_relative 'database_connection'

class Listing

  attr_reader :bookings, :id, :owner_id, :title, :address, :description, :price

  def initialize(id:, owner_id:, title:, address:, description:, price:)
    @id = id
    @owner_id = owner_id
    @title = title
    @address = address
    @description = description
    @price = price
    @bookings = []
  end

  def self.all
    DatabaseConnection.start

    rows = DatabaseConnection.query('SELECT * FROM listings')
    rows.map do |listing|
      Listing.new(id: listing['id'], owner_id: listing['owner_id'], title: listing['title'], address: listing['address'], description: listing['description'], price: listing['price'])
    end
  end

  def self.create(owner_id:, title:, address:, description:, price:)
    DatabaseConnection.start

    result = DatabaseConnection.query("INSERT INTO listings(owner_id, address, description, price, title) VALUES('#{owner_id}', '#{address}', '#{description}', '#{price}', '#{title}') RETURNING id, owner_id, address, description, price, title;")
    Listing.new(id: result[0]['id'], owner_id: result[0]['owner_id'], title: result[0]['title'], address: result[0]['address'], description: result[0]['description'], price: result[0]['price'])
  end

  def self.find_by_id(id)
    DatabaseConnection.start
    found_listing = DatabaseConnection.query("SELECT * FROM listings WHERE id = #{id}")
    Listing.new(id: found_listing[0]['id'], owner_id: found_listing[0]['owner_id'], title: found_listing[0]['title'], address: found_listing[0]['address'], description: found_listing[0]['description'], price: found_listing[0]['price'])
  end

  # def add_booking(user_id:, start_date:, end_date:, no_of_people:, total_price:)
  #   DatabaseConnection.start
  #   booking = DatabaseConnection.query("INSERT INTO bookings(listing_id, user_id, start_date, end_date, no_of_people, total_price) VALUES('#{@id}', '#{user_id}', '#{start_date}', '#{end_date}', '#{no_of_people}', '#{total_price}') RETURNING id, user_id, start_date, end_date, no_of_people, total_price")
  #   @bookings << booking
  # end


end
