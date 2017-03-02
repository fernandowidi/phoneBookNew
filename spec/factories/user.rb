require 'ffaker'

FactoryGirl.define do
  factory :user, class: User do
    email (FFaker::Internet.email)
    password '123456789'
  end
end
