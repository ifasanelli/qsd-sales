require 'rails_helper'

feature 'User finish order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit root_path
    click_on 'Pedidos'
    click_on order.code.to_s
    click_on 'Aprovar'

    expect(page).to have_content('Pedido aprovado com sucesso')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aprovado')
    expect(page).not_to have_link('Aprovar')
  end

  xscenario 'and coupon must be valid' do
    # Mock do cupom
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer, coupon: coupon.id)

    visit root_path
    click_on 'Pedidos'
    click_on order.code.to_s
    click_on 'Aprovar'

    expect(page).to have_content('Cupom inválido')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aberto')
  end
end
