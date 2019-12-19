feature "add new listing" do
  scenario "should add a new listing on listings" do
    listing = Listing.create(owner_id: '1', title: 'Makers Academy', address: 'test_address_1', description: 'test_description_1', price: '1')    
    visit '/listing/new'
    fill_in("title", with: "Makers Academy")
    fill_in("address", with: "test_address_1")
    fill_in("description", with: "test_description_1")   
    fill_in("price", with: "1")
    click_button("Submit")
    
    expect(page).to have_content listing.title
  end
end