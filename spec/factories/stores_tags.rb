FactoryBot.define do
  factory :stores_tag do
    name         { Faker::Company.name }
    address      { Faker::Address.full_address }
    station      { Faker::Address.state }
    price        { Faker::Number.number }
    store_time   { Faker::Lorem.sentence }
    link         { Faker::Internet.url(host: 'example.com') }
    word         { Faker::Lorem.word }

    after(:build) do |stores_tag|
      stores_tag.image.attach(io: File.open('public/images/test_sample.jpg'), filename: 'test_sample.jpg')
    end
  end
end

