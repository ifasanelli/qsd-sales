require 'rails_helper'

feature 'User view all orders' do
  scenario 'Sucessfully' do
    user = create(:user, email: 'xaviervi@hotmail.com')
    order = create(:order, code: 'ABC123')

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content(order.user.id)
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
    expect(page).to have_content(order.product_id)
  end

  scenario 'User view order' do
    user = create(:user, email: 'xaviervi@hotmail.com')
    order = create(:order)
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)
    prices = [Price.new(1, 1, 1, 'Mensal')]
    allow(Price).to receive(:all).and_return(prices)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    within("tr#order-#{order.id}") do
      find("a[href='#{order_path(order)}'][data-method='get']").click
    end

    expect(page).to have_content(order.user.id)
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
    expect(page).to have_content(order.product_id)
  end
end
