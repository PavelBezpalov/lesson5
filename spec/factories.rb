FactoryGirl.define do
  factory :user do
    name 'Pavel'
    sequence(:email) { |n| "pavel.bezpalov#{n}@cyber-wizard.com" }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :post do
    sequence(:title) { |n| "Post#{ n * rand(50) * rand(100..200)}" }
    body 'Body of the first post'
    tags 'some, tags, here'
    user_id { create(:user).id }
  end
end