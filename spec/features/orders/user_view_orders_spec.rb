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
    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'ABC123'

    expect(page).to have_content(order.user.id)
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
    expect(page).to have_content(order.product_id)
  end
end
