module LoginHelpers
  def login(user)
    visit '/'
    click_link 'Log In'

    expect(page).to have_content('Password')

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end
end