require 'booking'

describe "Booking" do

  before(:each) do
    booking = Booking.create(listing_id: 2, user_id: 1, start_date: '02-04-1995', end_date: '04-04-3939', no_of_people: 3, total_price: 70)
  end

  describe ".create" do
    it "should a booking to the database and store it on the listing" do
      booking_test = Booking.create(listing_id: 2, user_id: 1, start_date: '02-04-1995', end_date: '04-04-3939', no_of_people: 3, total_price: 70)

      expect(booking_test).to be_a Booking
      expect(booking_test.start_date).to eq '02-04-1995'
    end
  end
end
