feature "individual listing" do

  scenario "should go to the booking page " do
    listing = Listing.create(owner_id: '1', title: 'Makers Academy', address: 'test_address_1', description: 'test_description_1', price: '1')    
    visit '/listings'
    find("a[href='/listing/#{listing.id}']").click
    
    expect(page).to have_content listing.title
  end

end