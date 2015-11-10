require 'rails_helper'

describe 'Logging In' do
  let!(:user) { User.create(name: 'Pavel',
                     email: 'pavel.bezpalov@cyber-wizard.com',
                     password: '12345678',
                     password_confirmation: '12345678') }
  it 'logs the user in and goes to the posts' do
    visit new_session_path
    fill_in 'Email Address', with: 'pavel.bezpalov@cyber-wizard.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log In'

    expect(page).to have_content('New Post')
    # TODO: Find why log in not works with js
    # expect(page).to have_content('You successfully logging in')
  end

  it 'displays the email address in the event of a failed login' do
    visit new_session_path
    fill_in 'Email Address', with: 'pavel.bezpalov@cyber-wizard.com'
    fill_in 'Password', with: 'incorrect'
    click_button 'Log In'

    expect(page).to have_content('Password incorrect')
    expect(page).to have_field('Email Address', with: 'pavel.bezpalov@cyber-wizard.com')
  end
end