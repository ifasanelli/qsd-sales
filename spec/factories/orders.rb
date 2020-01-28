FactoryBot.define do
  factory :order do
    code { 'MyString' }
    date_order { '2020-01-28' }
    status { 0 }
    user { nil }
    costumer { nil }
    product { 'MyString' }
  end
end
