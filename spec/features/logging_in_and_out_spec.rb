feature 'authentication' do
  scenario 'a user can sign in' do
    sign_up
    sign_in

    expect(page).to have_content('Daniel')
  end

  scenario 'a user can log out' do
    User.create(name: 'Daniel', username: 'programmingMachine', email: 'text@example.com', password: 'shhh')
    sign_in

    expect(page).to have_content('Daniel')

    visit ('/')
    click_button('Sign out')
    expect(page).to_not have_content('Daniel')
  end
end

