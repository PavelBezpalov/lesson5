require 'rails_helper'

describe 'Search posts' do
  before do
    user = create(:user)
    create(:post, user_id: user.id, body: 'lemon')
    create(:post, user_id: user.id, body: 'apple')
    create(:post, user_id: user.id, title: 'cherry')
  end

  it "find no posts when word 'horse' submitted" do
    visit '/'

    fill_in 'search', with: 'horse'
    click_button 'Search'

    expect(page).to_not have_content('lemon')
  end

  it "find post with body contain 'lemon' when word 'lemon' submitted" do
    visit '/'

    fill_in 'search', with: 'lemon'
    click_button 'Search'

    expect(page).to have_content('lemon')
  end

  it "find post with title contain 'cherry' when word 'cherry' submitted" do
    visit '/'

    fill_in 'search', with: 'cherry'
    click_button 'Search'

    expect(page).to have_content('cherry')
  end
end
