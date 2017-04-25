FactoryGirl.define do
  factory :ride do
    start_coordinates [50.06465, 19.94498]
    end_coordinates [50.067456, 19.988809]
    cost 2495
    ride_date Date.current
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
