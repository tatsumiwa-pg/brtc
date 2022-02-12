module SignUpSupport
  def sign_up(user)
    basic_auth(root_path)
    # JavaScript 起動のため一度読み込みを行う
    visit root_path
    find('#user_menu_btn').click
    expect(page).to have_selector('ul', class: 'user-menu-lists')
    find('a', text: '新規登録').click
    expect(current_path).to eq new_user_registration_path
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password_confirmation
    find('input[name="commit"]').click
  end
end
