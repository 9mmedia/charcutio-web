FactoryGirl.define do
  sequence :username do |n|
    "username-#{n}"
  end

  sequence :name do |n|
    "name-#{n}"
  end

  sequence :email do |n|
    "example-#{n}@example.com"
  end

  sequence :unique_key do |n|
    "#{n}-unique"[0..4]
  end

  sequence :url do |n|
    "http://test.host/full/#{n}"
  end

  # User
  factory :user do
    name 'first_name last_name'
    email { FactoryGirl.generate :email }
    password 'password'
  end
end
