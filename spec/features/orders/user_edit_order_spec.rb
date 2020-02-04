require 'rails_helper'

feature 'User edit any order' do
  scenario 'Sucessfully' do
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
    select '3 meses', from: 'Período'
    click_on 'Efetivar'

    expect(page).to have_content(order.user.id)
    expect(page).to have_content('Hospedagem Windows')
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
  end
end
