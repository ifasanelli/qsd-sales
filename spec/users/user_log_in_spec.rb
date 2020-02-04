require 'rails_helper'

feature 'User log in' do
  scenario 'from home page' do
    user = User.create!(email: 'it@it.com', password: '123456', role: :admin)
    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'E-mail', with: 'it@it.com'
      fill_in 'Senha', with: '123456'
      click_on 'Log in'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content('Sair')
    expect(page).to_not have_content('Entrar')
    expect(page).to have_content("Olá, #{user.email}")
  end

  scenario 'user log out' do
    user = User.create!(email: 'it@it.com', password: '123456', role: :admin)
    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'E-mail', with: 'it@it.com'
      fill_in 'Senha', with: '123456'
      click_on 'Log in'
    end
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).to have_content('Entrar')
    expect(page).to_not have_content('Sair')
    expect(page).to_not have_content("Olá, #{user.email}")
  end
end
