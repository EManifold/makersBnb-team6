feature 'confirmation' do
  scenario 'should show a message thanking for booking that property' do
    listing = Listing.create(owner_id: '1', title: 'test_title_1', address: 'test_address_1', description: 'test_description_1', price: '1')
    visit("/book/#{listing.id}")
    fill_in "StartDate", with: '04-02-2010'
    fill_in "EndDate", with: '02-04-2020'
    fill_in('NumberOfPeople', with: 78)
    click_on 'Submit'
    expect(page).to have_content "Thank you for booking with Makers Bnb"
    expect(page).to have_content "78"
  end
end
