require 'rails_helper'

feature 'User edit any order' do
  scenario 'Sucessfully' do
    price = Price.new(id: 3, name: '3 Meses', float_value: 30)
    user = create(:user, email: 'xaviervi@hotmail.com')
    order = create(:order)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    within("tr#order-#{order.id}") do
      find("a[href='#{order_path(order)}'][data-method='get']").click
    end
    click_on 'Editar'

    select 'Hospedagem', from: 'Produto'
    select 'Windows', from: 'Plano'
    select "#{price.name} - #{price.valor}", from: 'Preço'
    click_on 'Efetivar'

    expect(page).to have_content(order.user.id)
    expect(page).to have_content(order.customer.name)
    expect(page).to have_content(order.customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Windows')
    expect(page).to have_content("#{price.name} - #{price.valor}")
  end

  scenario 'by index' do
    price = Price.new(id: 3, name: '3 Meses', float_value: 30)
    user = create(:user, email: 'xaviervi@hotmail.com')
    order = create(:order)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    within("tr#order-#{order.id}") do
      find("a[href='#{edit_order_path(order)}']").click
    end

    select 'Hospedagem', from: 'Produto'
    select 'Windows', from: 'Plano'
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
