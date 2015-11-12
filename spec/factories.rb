FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post#{ n * rand(50) * rand(100..200)}" }
    body 'Body of the first post'
    tags 'some, tags, here'
    user
    factory :post_invalid do
      title ''
      body ''
    end
  end

  factory :user do
    name 'Pavel'
    email 'pavel.bezpalov@cyber-wizard.com'
    password '12345678'
    password_confirmation '12345678'
    factory :user_with_diff_email do
      sequence(:email) { |n| "pavel.bezpalov#{n}@cyber-wizard.com" }
    end
  end
end