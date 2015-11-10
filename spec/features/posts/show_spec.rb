require 'rails_helper'

describe 'Show post' do
  let!(:post) {create(:post)}

  it 'does not requires login' do
    visit "/posts/#{post.id}"
    expect(page).to_not have_content('You must be logged in')
  end

  it 'with .json outputs post' do
    visit "/posts/#{post.id}.json"

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.name)
  end
end
