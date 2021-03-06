require 'rails_helper'

feature 'User create costumer' do
  scenario 'Successfully' do
    # Act
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: 'Douglas Adams'
    fill_in 'Endereço', with: 'Restaurante no fim do Universo'
    fill_in 'CPF', with: '198.725.668-02'
    fill_in 'E-mail', with: 'douglas@gmail.com'
    fill_in 'Telefone', with: '(11) 96782-4553'
    fill_in 'Data de nascimento', with: '1997-01-28'
    click_on 'Salvar'
    # Assert
    expect(page).to have_content('Douglas Adams')
    expect(page).to have_content('Restaurante no fim do Universo')
    expect(page).to have_content('198.725.668-02')
    expect(page).to have_content('(11) 96782-4553')
    expect(page).to have_content('1997-01-28')
  end

  scenario 'Duplicated fields' do
    create(:customer, document: '198.725.668-02',
                      phone: '(11) 96782-4553',
                      email: 'douglas@gmail.com')
    # Act
    visit customers_path
    click_on 'Registrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CPF', with: '198.725.668-02'
    fill_in 'E-mail', with: 'douglas@gmail.com'
    fill_in 'Telefone', with: '(11) 96782-4553'
    fill_in 'Data de nascimento', with: ''
    click_on 'Salvar'
    # Assert
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CPF já está em uso')
    expect(page).to have_content('E-mail já está em uso')
    expect(page).to have_content('Telefone já está em uso')
  end
end
