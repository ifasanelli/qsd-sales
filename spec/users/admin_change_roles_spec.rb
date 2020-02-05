require 'rails_helper'

feature 'Admin change role' do
  scenario 'successfully' do
    other_user = User.create!(email: 'test@test.com', password: '654321', role: :seller)
    user = User.create!(email: 'it@it.com', password: '123456', role: :admin)
    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'E-mail', with: 'it@it.com'
      fill_in 'Senha', with: '123456'
      click_on 'Log in'
    end
    click_on 'Usuários'
    first('.edit-button').click
    find('#user_role_admin').click
    click_on 'Update'

    expect(current_path).to eq(users_path)
    #expect(page).to have_content('E-mail')
  end
end