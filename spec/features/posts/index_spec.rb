require 'rails_helper'

describe 'Listings posts' do
  it 'does not requires login' do
    visit '/posts'
    expect(page).to_not have_content('You must be logged in')
  end
end