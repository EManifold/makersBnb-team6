require 'listing'
require 'pg'

describe "Listing" do
  connection = PG.connect(dbname: "makersbnb_test")

  describe ".all" do
    it "should display the listings" do
      listing = Listing.create(owner_id: 001, title: 'test_title_1', address: 'test_address_1', description: 'test_description_1', price: 'test_price_1')
      Listing.create(owner_id: 002, title: 'test_title_2', address: 'test_address_2', description: 'test_description_2', price: 'test_price_2')
      Listing.create(owner_id: 003, title: 'test_title_3', address: 'test_address_3', description: 'test_description_3', price: 'test_price_3')

      listings = Listing.all

      expect(listings.length).to eq 3
      expect(listings.first.title).to eq 'test_title_1'
      expect(listings.first.address).to eq 'test_address_1'
      expect(listings.last.title).to eq 'test_title_3'
    end
  end

  describe ".create" do
    it "should create a new instance of listing and add it to the db" do
      listing = Listing.create(owner_id: 001, title: 'test_title', address: 'test_address_1', description: 'test_description', price: 'test_price')

      expect(listing).to be_a Listing
      expect(listing.title).to eq 'test_title'
      expect(listing.address).to eq 'test_address_1'
    end
  end

  describe ".find_by_id" do
    it "should find the listing based on id" do
      listing = Listing.create(owner_id: 001, title: 'test_title', address: 'test_address_1', description: 'test_description', price: 'test_price')
      result = Listing.find_by_id(listing.id)
      expect(result.title).to eq listing.title
    end
  end

  describe ".search" do
  it "should return only results matching key words" do
    Listing.create(owner_id: 002, title: 'test_title_7', address: 'test_address_7', description: 'test_description_7', price: 'test_price_7')
    Listing.create(owner_id: 003, title: 'test_title_3', address: 'test_address_3', description: 'test_description_3', price: 'test_price_3')
    results = Listing.search('test_title_7')
    expect(results[0].address).to eq ('test_address_7')
  end
  
  end

end
