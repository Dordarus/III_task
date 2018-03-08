FactoryBot.define do
  factory :books_topic do
    
  end
  factory :topic do
    
  end
  factory :book do
    
  end
  factory :profile do
    
  end
    factory :user do
      name                  "Daniel Vysotskyi"
      email                 "daniel@example.com"
      password              "some words"
      password_confirmation "some words"
    end

    factory :confirmed_user, :parent => :user do
        before(:create) { |user| user.skip_confirmation! }
    end
end