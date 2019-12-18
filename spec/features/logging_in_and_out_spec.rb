feature 'authentication' do
  scenario 'a user can sign in' do
    user = User.create(name: 'Daniel', username: 'programmingMachine', email: 'test@example.com', password: 'shh')

    visit('/login/new')
    fill_in(email: 'text@example.com')
    fill_in(password: 'shhh')
    click_button('Submit')
    expect(page).to have_content(user.name)
  end
end
