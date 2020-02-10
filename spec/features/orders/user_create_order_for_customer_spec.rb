require 'rails_helper'

feature 'User create order' do
  xscenario 'Successfully' do
    user = create(:user)
    customer = create(:customer)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo pedido'

    select "#{customer.name} - #{customer.document}"
    select 'Hospedagem Linux', from: 'Produto'
    click_on 'Efetivar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem Linux')
  end

  xscenario 'When have no product, plan or period' do
    user = create(:user)

    login_as user, scope: :user
    visit new_order_path
    click_on 'Efetivar'

    expect(page).to have_content('Produto não pode ficar em branco')
    expect(page).to have_content('Preco não pode ficar em branco')
    expect(page).to have_content('Planos não pode ficar em branco')
    expect(page).to have_content('Produtos')
    expect(page).to have_content('Planos')
    expect(page).to have_content('Período')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Cloud')
    expect(page).to have_content('Windows')
    expect(page).to have_content('Linux')
    expect(current_path).to eq new_customer_path
  end
end
