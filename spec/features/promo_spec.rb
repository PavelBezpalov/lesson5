require 'rails_helper'

describe 'Promo message', :js => true do
  it 'is not shown when page loaded' do
    visit '/'

    expect(page).to_not have_content('GeekHub')
  end

  it 'is not shown on 5th action', :js => true do
    visit '/'
    5.times { click_link 'Home' }

    expect(page).to_not have_content('GeekHub')
  end

  it 'is shown on 10th action', :js => true do
    visit '/'
    10.times { click_link 'Home' }

    expect(page).to have_content('GeekHub')
  end

  it 'is not shown on 11th action', :js => true do
    visit '/'
    11.times { click_link 'Home' }

    expect(page).to_not have_content('GeekHub')
  end
end