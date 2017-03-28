FactoryGirl.define do
  factory :comment do
    post_id 1
    content  "TestComment"
  end
  factory :invalid_comment, class: "Comment" do
    post_id 1
  end
end