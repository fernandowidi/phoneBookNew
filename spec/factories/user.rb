FactoryGirl.define do
  factory :user, class: User do
    email (Faker::Internet.email)
    password '123456789'
  end
end
