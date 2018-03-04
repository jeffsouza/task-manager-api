FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '123456'
    password_confirmation '123456'
    auth_token { Digest::SHA1.hexdigest([Time.now, rand].join) }
  end
end