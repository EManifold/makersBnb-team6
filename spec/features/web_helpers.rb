def sign_up
  visit('/')
  click_button('Sign Up')

  fill_in 'name', with: 'Daniel'
  fill_in 'username', with: 'programmingMachine'
  fill_in 'email', with: 'text@example.com'
  fill_in 'password', with: 'shhh'
  click_button('Submit')
end

def sign_in
  visit('/')
  click_button('login')
  fill_in 'email', with: 'text@example.com'
  fill_in 'password', with: 'shhh'
  click_button('login')
end