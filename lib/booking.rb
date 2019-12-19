require 'pg'
require_relative 'database_connection'

class Booking

  attr_reader :id, :listing_id, :user_id, :start_date, :end_date, :no_of_people, :total_price

  def initialize(id:, listing_id:, user_id:, start_date:, end_date:, no_of_people:, total_price:)
    @id = id
    @listing_id = listing_id
    @user_id = user_id
    @start_date = start_date
    @end_date = end_date
    @no_of_people = no_of_people
    @total_price = total_price
  end

  def self.create(listing_id:, user_id:, start_date:, end_date:, no_of_people:, total_price:)
    DatabaseConnection.start

    result = DatabaseConnection.query("INSERT INTO bookings(listing_id, user_id, start_date, end_date, no_of_people, total_price) VALUES('#{listing_id}', '#{user_id}', '#{start_date}', '#{end_date}', '#{no_of_people}', '#{total_price}') RETURNING id, listing_id, user_id, start_date, end_date, no_of_people, total_price")
    Booking.new(id: result[0]['id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], no_of_people: result[0]['no_of_people'], total_price: result[0]['total_price'])
  end

  def self.find_by_id(id)
    DatabaseConnection.start
    found_booking = DatabaseConnection.query("SELECT * FROM bookings WHERE id = #{id}")
    Booking.new(id: found_booking[0]['id'], listing_id: found_booking[0]['listing_id'], user_id: found_booking[0]['user_id'], start_date: found_booking[0]['start_date'], end_date: found_booking[0]['end_date'], no_of_people: found_booking[0]['no_of_people'], total_price: found_booking[0]['total_price'])
  end

  def self.find_used_dates(listing_id)
    DatabaseConnection.start
    found_dates = DatabaseConnection.query("SELECT start_date, end_date FROM bookings WHERE listing_id = #{listing_id}")
    Booking.new(id: found_dates[0]['id'], listing_id: found_dates[0]['lisitng_id'], user_id: found_dates[0]['user_id'], start_date: found_dates[0]['start_date'], end_date: found_dates[0]['end_date'], no_of_people: found_dates[0]['no_of_people'], total_price: found_booking[0]['total_price'] )
  end

end
