require 'rails_helper'

describe 'Deleting posts' do
  before do
    user = create(:user)
    login(user)
    @post = create(:post, user_id: user.id)
  end

  it 'is successful when clicking the destroy link' do
    visit '/'

    within "#post_#{@post.id}" do
      click_button 'Destroy'
    end

    expect(page).to_not have_content(@post.title)
    expect(Post.count).to eq(0)
  end
end
