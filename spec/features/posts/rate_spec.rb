require 'rails_helper'

describe 'Rate system' do
  let!(:post) {create(:post)}
  let!(:post2) {create(:post)}

  context 'buttons on post show page' do
    it 'not visible for not logged user' do
      visit "/posts/#{post.id}"
      expect(page).to_not have_button('Like')
      expect(page).to_not have_button('Dislike')
    end

    it 'not visible for user own posts', js: true do
      login(post.user)
      visit "/posts/#{post.id}"
      expect(page).to_not have_button('Like')
      expect(page).to_not have_button('Dislike')
    end

    it 'visible for other user\'s posts', js: true do
      login(post.user)
      visit "/posts/#{post2.id}"
      expect(page).to have_button('Like')
      expect(page).to have_button('Dislike')
    end
  end
end
