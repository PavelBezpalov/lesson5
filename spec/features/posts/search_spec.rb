require 'rails_helper'

describe 'Search posts' do
  before do
    user = create(:user)
    create(:post, title: 'Lemon',
           body: 'The lemon (Citrus × limon) is a species of small ' \
                 'evergreen tree native to Asia.',
           user: user)
    create(:post, title: 'Apple',
           body: 'The apple tree (Malus domestica) is a deciduous tree ' \
                 'in the rose family best known for its sweet, pomaceous ' \
                 'fruit, the apple.',
           user: user)
    create(:post, title: 'cherry',
           user: user)
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

  it "find post with title contain 'cherry' when word 'cherry' submitted" do
    visit '/'

    fill_in 'search', with: 'cherry'
    click_button 'Search'

    expect(page).to have_content('cherry')
  end

  it "find posts case-insensitivity" do
    visit '/'

    fill_in 'search', with: 'CHERRY'
    click_button 'Search'

    expect(page).to have_content('cherry')
  end

  it "find posts by more than 1 words in a row" do
    visit '/'

    fill_in 'search', with: 'Malus domestica rose family'
    click_button 'Search'

    expect(page).to have_content('Apple')
  end
end
