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

  describe ".find_by_id" do
    it "should find the listing based on id" do
      booking = Booking.create(listing_id: 2, user_id: 1, start_date: '02-04-1995', end_date: '04-04-3939', no_of_people: 3, total_price: 70)
      result = Booking.find_by_id(booking.id)
      expect(result.start_date).to eq booking.start_date
    end
  end

  describe ".price_check" do
    it "Calculates the price of a stay from length and price per night" do
      expect(Booking.price_check('2019-12-10','2019-12-20','1','2')).to eq('20')
      expect(Booking.price_check('2019-11-30','2019-12-30','1', '2')).to eq('60')
      expect(Booking.price_check('2019-12-05','2019-12-20','1', '2')).to eq('30')
    end
  end

end
