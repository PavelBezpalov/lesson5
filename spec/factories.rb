FactoryGirl.define do
  factory :post do
    sequence(:title) { Forgery('basic').text }
    body Forgery('lorem_ipsum').characters(141)
    tags (Forgery('name').first_name + ' ') * 3
    user
  end

  factory :user do
    name Forgery('name').first_name
    email Forgery('internet').email_address
    password Forgery('basic').password
    password_confirmation { password }
  end
end