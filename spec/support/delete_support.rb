module DeleteUserSupport
  def delete_user(_user)
    expect(page).to have_content(@user.nickname.to_s)
    visit edit_user_registration_path
    page.accept_confirm do
      click_on :cancel_btn
    end
  end
end
