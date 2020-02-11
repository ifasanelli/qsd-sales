require 'rails_helper'

feature 'User finish order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)

    visit root_path
    click_on 'Pedidos'
    within("tr#order-#{order.id}") do
      find("a[href='#{order_path(order)}'][data-method='get']").click
    end
    click_on 'Aprovar'

    expect(page).to have_content('Pedido aprovado com sucesso')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aprovado')
    expect(page).not_to have_link('Aprovar')
  end
end
