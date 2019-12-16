require 'listing'
require 'pg'

describe "Listing" do
  
  connection = PG.connect(dbname: "makersbnb_test")

  describe ".all" do
    it "should display the listings" do
      
      listing_1 = connection.exec("INSERT INTO listings(owner_id, address)VALUES ('001', 'test_address_1');")
      listing_2 = connection.exec("INSERT INTO listings(owner_id, address)VALUES ('002', 'test_address_2');")
      listing_3 = connection.exec("INSERT INTO listings(owner_id, address)VALUES ('003', 'test_address_3');")

      listings = Listing.all

      expect(listings).to include 'test_address_1'      
      expect(listings).to include 'test_address_2'
      expect(listings).to include 'test_address_3'

    end
  end

end