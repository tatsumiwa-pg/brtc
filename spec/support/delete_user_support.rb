module DeleteUserSupport
  def delete_user(_user)
    find('#user_image').click
    expect(page).to have_selector('ul', class: 'user-menu-lists')
    expect(page).to have_content(@user.nickname)
    expect(page).to have_content('アカウント編集')
    find('a', text: 'アカウント編集').click
    page.accept_confirm do
      click_on :cancel_btn
    end
  end
end
