FactoryGirl.define do
  factory :user do
    email "email@server.com"
    password "12345678"
    password_confirmation "12345678"
    name "Bob Schmidt"
  end

  factory :invalid_user, parent: :user do
    name nil
  end
end
