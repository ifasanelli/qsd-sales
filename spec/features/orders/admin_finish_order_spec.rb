require 'rails_helper'

feature 'Admin finish order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit order_path(order)
    # click_on 'Pedidos'
    # click_on "#{order.code}"
    click_on 'Aprovar'

    expect(page).to have_content('Pedido aprovado com sucesso')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aprovado')
  end
end