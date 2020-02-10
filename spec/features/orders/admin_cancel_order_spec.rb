require 'rails_helper'

feature 'Admin cancel order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit root_path
    click_on 'Pedidos'
    click_on order.code.to_s
    click_on 'Cancelar'
    fill_in 'Motivo de cancelamento', with: 'Não podemos realizar o pedido'
    click_on 'Enviar'

    expect(page).to have_content('Pedido cancelado com sucesso')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Cancelado')
    expect(page).to have_content('Motivo de cancelamento')
    expect(page).to have_content('Não podemos realizar o pedido')
    expect(page).not_to have_link('Cancelar')
  end

  scenario 'and cancellation reason should not be empty' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit order_path(order)
    click_on 'Cancelar'
    click_on 'Enviar'

    expect(page).to have_content('Motivo de cancelamento não pode ficar' \
                                 ' em branco')
    expect(page).to have_content(order.code.to_s)
  end
end
