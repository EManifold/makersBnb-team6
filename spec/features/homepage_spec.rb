feature "homepage" do
  scenario "check the content on homepage" do
    visit '/'
    expect(page).to have_content("MakersBnb")
  end

  scenario "check the navbar links on homepage" do
    visit '/'
    find("a[href='/login/new']").click
    expect(page).to have_content("Email:")
  end
  
end