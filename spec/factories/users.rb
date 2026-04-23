FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'1a2b3c4d'}
    password_confirmation {password}
    last_name             {'田高田'}
    first_name            {'誠'}
    last_name_kana        {'タコウダ'}
    first_name_kana       {'マコト'}
    birth_date            {'1930-01-01'}
  end
end