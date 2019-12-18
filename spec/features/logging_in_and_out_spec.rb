feature 'authentication' do
  scenario 'a user can sign in' do
    visit('/')
    click_button('Sign Up')

    fill_in 'name', with: 'Daniel'
    fill_in 'username', with: 'programmingMachine'
    fill_in 'email', with: 'text@example.com'
    fill_in 'password', with: 'shhh'
    user = User.create(name: 'Daniel', username: 'programmingMachine', email: 'test@example.com', password: 'shhh')
    click_button('Submit')

    click_button('login')
    fill_in 'email', with: 'text@example.com'
    fill_in 'password', with: 'shhh'
    click_button('login')

    expect(page).to have_content(user.name)
  end
end
