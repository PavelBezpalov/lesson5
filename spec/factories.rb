FactoryGirl.define do
  factory :post do
    sequence(:title) { Forgery('basic').text }
    body Forgery('lorem_ipsum').characters(141)
    tags (Forgery('name').first_name + ' ') * 3
    user
  end

  factory :user do
    sequence(:name) { Forgery('name').first_name }
    sequence(:email) { Forgery('internet').email_address }
    sequence(:password) { Forgery('basic').password }
    password_confirmation { password }
  end
end