FactoryBot.define do
  factory :order do
    code { 'ABC123' }
    date_order { '2020-01-28' }
    status { 0 }
    user
    customer
    product { 'MyString' }
  end
end
