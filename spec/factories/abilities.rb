require 'ffaker'

FactoryGirl.define do
  factory :ability, class: User do
    trait :adm do
      email (FFaker::Internet.email)
      password '12vrfbyutg67t87687by345'
      role 'adm'
    end

    trait :usr do
      email (FFaker::Internet.email)
      password '123yturt76bu7tby7y8970845'
      role 'usr'
    end
  end
end
