FactoryBot.define do
  factory :costumer do
    name { "João" }
    address { "SP" }
    document { "36971828876" }
    email { "joao@gmail.com" }
    phone { "11-967679823" }
    birth_date { "2002-01-28" }
  end
end
