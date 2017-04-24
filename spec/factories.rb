FactoryGirl.define do
  factory :ride do
    start_coordinates [54.0000, 54.000]
    end_coordinates [54.1111, 54.1111]
    cost 2495
    taxi_provider factory: :taxi_provider
    user factory: :user
  end

  factory :taxi_provider do
    name 'uber'
  end

  factory :user do
    email 'test_user@mail.com'
    username 'test_user'
    password 'secret'
  end

  factory :application do
    name 'App1'
  end
end
