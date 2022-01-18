module DeleteUserSupport
  def delete_user(user)
    expect(page).to have_content("#{@user.nickname}")
    visit edit_user_registration_path
    page.accept_confirm do
      click_on :cancel_btn
    end
  end
end