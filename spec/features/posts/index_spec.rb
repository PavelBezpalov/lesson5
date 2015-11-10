require 'rails_helper'

describe 'Listings posts' do
  it 'does not requires login' do
    visit '/posts'
    expect(page).to_not have_content('You must be logged in')
  end

  it 'with .json outputs all posts' do
    posts = create_list(:post, 5)
    visit '/posts.json'

    expect(page).to have_content(posts[0].title)
    expect(page).to have_content(posts[0].user.name)
    expect(page).to have_content(posts[4].title)
    expect(page).to have_content(posts[4].user.name)
  end
end