require 'rails_helper'

describe 'Editing posts', js: true do
  def update_post(*options)
    @attrs = attributes_for(:post, *options )

    visit '/'
    within "#post_#{@post.id}" do
      click_button 'Edit'
    end

    fill_in 'Title', with: @attrs[:title]
    page.execute_script( "simplemde.value('#{ @attrs[:body]}')" )
    fill_in 'Tags', with: @attrs[:tags]
    click_button 'Update Post'
  end

  before do
    @post = create(:post)
    login(@post.user)
  end

  it 'updates a post successfully with correct information' do
    update_post

    expect(page).to have_content('Post was successfully updated.')
    expect(page).to have_content(@attrs[:title].upcase)
    expect(page).to have_content(@attrs[:body])
  end

  it 'displays an error with no title' do
    update_post title: ''
    expect(page).to have_content("can't be blank")
  end

  it 'displays an error with too short a title' do
    update_post title: Forgery('basic').text(at_least: 1, at_most: 4)
    expect(page).to have_content('is too short')
  end

  it 'displays an error with too long a title' do
    update_post title: Forgery('basic').text(at_least: 141, at_most: 145)
    expect(page).to have_content('is too long')
  end

  it 'displays an error with no body' do
    update_post body: ''
    expect(page).to have_content("can't be blank")
  end
end
