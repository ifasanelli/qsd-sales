require 'rails_helper'

feature 'User search costumer for order' do
  scenario 'sucessfully' do
    Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    user = create(:user, email: 'tst@tst.com')
    customer = create(:customer, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: customer.document
    click_on 'Buscar'
    # Assert
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
  end

  scenario 'Customer belongs to another seller' do
    user = create(:user, email: 'tst@tst.com')
    create(:customer, document: '123.456.789-10', user: user)
    other_user = create(:user, email: 'email@email.com')

    login_as other_user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '123.456.789-10'
    click_on 'Buscar'

    expect(page).to have_content('Este cliente pertence a outro vendedor')
  end

  scenario 'Customer does not exit, create a new one' do
    user = create(:user, email: 'tst@tst.com')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '999.999.999-99'
    click_on 'Buscar'

    expect(current_path).to eq new_customer_path
  end
end
