feature 'authentication' do
  scenario 'a user can sign in' do
    visit '/sign-up'
    fill_in("name", with: "Daniel")
    fill_in("email", with: "Daniel@gmail")
    fill_in("password", with: "1234")
    fill_in("username", with: "danielm")
    click_button "Submit"

    expect(page).to have_content('Daniel')
  end

  scenario 'a user can log out' do
    visit '/sign-up'
    fill_in("name", with: "Daniel")
    fill_in("email", with: "Daniel@gmail")
    fill_in("password", with: "1234")
    fill_in("username", with: "danielm")
    click_button "Submit"
    find("a[href='/login/destroy']").click
    
    expect(page).not_to have_content('Daniel')
  end
end

