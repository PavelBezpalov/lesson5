require 'rails_helper'

describe 'Promo message' do
  it 'is not shown when page loaded' do
    visit '/'
    expect(page).to_not have_selector('div#promo', visible: false)
  end

  it 'is not shown on 5th action' do
    visit '/'
    5.times { click_link 'Home' }

    expect(page).to_not have_selector('div#promo', visible: false)
  end

  it 'is shown on 10th action' do
    visit '/'
    10.times { click_link 'Home' }

    expect(page).to have_selector('div#promo', visible: false)
  end
end