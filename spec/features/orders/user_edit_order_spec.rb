require 'rails_helper'

feature 'User edit any order' do
  scenario 'Sucessfully' do
    price = Price.new(id: 3, name: '3 Meses', float_value: 30)
    user = create(:user, email: 'xaviervi@hotmail.com')
    order = create(:order)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'ABC123'
    click_on 'Alterar'

    select "#{order.customer.name} - #{order.customer.document}"
    select 'Hospedagem', from: 'Produtos'
    select 'Windows', from: 'Planos'
    select price.expose, from: 'Preço'
    click_on 'Efetivar'

    expect(page).to have_content(order.user.id)
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Windows')
    expect(page).to have_content(price.expose)
  end
end
