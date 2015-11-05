require 'rails_helper'

describe 'Listings posts' do
  xit 'requires login' do
    visit '/posts'
    expect(page).to have_content('You must be logged in')
  end
end