require 'pg'
require_relative 'database_connection'

class Booking

  attr_reader :listing_id, :user_id, :start_date, :end_date, :no_of_people, :total_price

  def initialize(listing_id:, user_id:, start_date:, end_date:, no_of_people:, total_price:)
    @listing_id = listing_id
    @user_id = user_id
    @start_date = start_date
    @end_date = end_date
    @no_of_people = no_of_people
    @total_price = total_price
  end

  def self.create(listing_id:, user_id:, start_date:, end_date:, no_of_people:, total_price:)
    DatabaseConnection.start

    result = DatabaseConnection.query("INSERT INTO bookings(listing_id, user_id, start_date, end_date, no_of_people, total_price) VALUES('#{listing_id}', '#{user_id}', '#{start_date}', '#{end_date}', '#{no_of_people}', '#{total_price}') RETURNING listing_id, user_id, start_date, end_date, no_of_people, total_price")
    Booking.new(listing_id: result[0]['listing_id'], user_id: result[0]['user_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], no_of_people: result[0]['no_of_people'], total_price: result[0]['total_price'])
  end
end
