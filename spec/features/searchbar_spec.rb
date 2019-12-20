feature "searchbar" do 
  scenario "searchbar should return relevant result" do
    listing = Listing.create(owner_id: '1', title: 'Makers Academy', address: 'test_address_1', description: 'test_description_1', price: '1')    
    visit '/'
    fill_in("keyword", with: "Makers")
    click_button "submit"

    expect(page).to have_content listing.title
  end
end