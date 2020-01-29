require 'rails_helper'

feature 'Admin cancel order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit order_path(order)
    #click_on 'Pedidos'
    #click_on "#{order.code}"
    click_on 'Cancelar'
    fill_in 'Motivo do Cancelamento', with: 'Não podemos realizar o pedido'
    click_on 'Enviar'

    expect(page).to have_content('Pedido cancelado com sucesso')
    expect(page).to have_content("#{order.code}")
    expect(page).to have_content('Status: Cancelado')
    expect(page).to have_content('Motivo: Não podemos realizar o pedido')
    expect(page).not_to have_link('Cancelar')
  end

end