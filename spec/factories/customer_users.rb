FactoryBot.define do
  factory :customer_user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { 'a' * 6 }
    password_confirmation { password }
  
    after(:build) do |customer_user|
      customer_user.avatar.attach(io: File.open('public/images/profile-default.png'), filename: 'profile-default.png')
    end
  end
end
