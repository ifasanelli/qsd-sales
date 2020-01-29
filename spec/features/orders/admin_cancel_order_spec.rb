require 'rails_helper'

feature 'Admin cancel order' do
  scenario 'successfully' do
    order = create(:order)

    visit root_path
    click_on 'Pedidos'
    click_on "#{order.code}"
    click_on 'Cancelar'

    expect(page).to have_content('Pedido cancelado com sucesso')
    expect(page).to have_content("#{order.code}")
    expect(page).to have_content('Status: Cancelado')
    expect(order.reload.status).to be_cancelled
  end
end