FactoryGirl.define do
  factory :user do
    id 1
    email 'admin@gmx.de'
    password 'test12'
  end
  factory :normal_user, class: "User" do
    id 1
    email 'test@gmx.de'
    password 'test12'
  end
end
