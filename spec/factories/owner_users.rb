FactoryBot.define do
  factory :owner_user do
    name                  {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {'a' * 6}
    password_confirmation {password}
  end
end
