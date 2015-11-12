require 'rails_helper'

describe 'Creating posts', js: true do
  def create_post_item(options={})
    options[:title] ||= 'First post'
    options[:body] ||= 'B' * 141
    options[:tags] ||= 'some, tags, here'

    visit '/'
    click_link 'New Post'
    expect(page).to have_content('New Post')

    fill_in 'Title', with: options[:title]
    page.execute_script( "simplemde.value('#{options[:body]}')" )
    fill_in 'Tags', with: options[:tags]
    click_button 'Create Post'
  end

  before do
    user = create(:user)
    login(user)
  end

  it 'redirects to the post index page on success' do
    create_post_item

    expect(page).to have_content('First post'.upcase)
  end

  it 'displays an error when the post has no title' do
    create_post_item title: ''

    expect(page).to have_content("can't be blank")
  end

  it 'displays an error when the post has no body' do
    create_post_item body: ''

    expect(page).to have_content("can't be blank")
  end

  it 'displays an error when the post has a title with length less than 5
characters' do
    create_post_item title: 'A' * 4

    expect(page).to have_content('is too short')
  end

  it 'displays an error when the post has a title with length more than 100
characters' do
    create_post_item title: 'A' * 141

    expect(page).to have_content('is too long')
  end

  it 'displays an error when the post has the same title as existing post' do
    create_post_item

    expect(page).to have_content('First post'.upcase)

    create_post_item

    expect(page).to have_content('has already been taken')
  end
end