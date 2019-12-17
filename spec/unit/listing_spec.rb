require 'listing'
require 'pg'

describe "Listing" do
  connection = PG.connect(dbname: "makersbnb_test")

  describe ".all" do
    it "should display the listings" do
      listing = Listing.create(title: 'test_title_1', address: 'test_address_1', description: 'test_description_1', price: 'test_price_1')
      Listing.create(title: 'test_title_2', address: 'test_address_2', description: 'test_description_2', price: 'test_price_2')
      Listing.create(title: 'test_title_3', address: 'test_address_3', description: 'test_description_3', price: 'test_price_3')

      listings = Listing.all

      expect(listings.length).to eq 3
      expect(listings.first.title).to eq 'test_title_1'
      expect(listings.first.address).to eq 'test_address_1'
      expect(listings.last.title).to eq 'test_title_3'
    end
  end

  describe ".create" do
    it "should create a new instance of listing and add it to the db" do
      listing = Listing.create(title: 'test_title', address: 'test_address_1', description: 'test_description', price: 'test_price')

      expect(listing).to be_a Listing
      expect(listing.title).to eq 'test_title'
      expect(listing.address).to eq 'test_address_1'
    end
  end

end
