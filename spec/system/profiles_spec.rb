require 'rails_helper'

RSpec.describe 'プロフィール新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @profile = FactoryBot.build(:profile)
  end

  context 'プロフィールが新規登録ができるとき' do
    it '正しい情報を入力すればプロフィール新規登録ができてトップページへ遷移する' do
      # ユーザー新規登録
      sign_up(@user)
      # 現在のページがプロフィール新規作成ページであることを確認する
      expect(current_path).to eq(new_profile_path)
      # プロフィール情報を入力する(セレクトボックスはchromedriverが関数エラーを起こすため物理的に数字を入れる)
      find('#profile_age').find("option[value='2']").select_option
      fill_in 'job_input', with: @profile.job
      fill_in 'skills_input', with: @profile.skills
      fill_in 'address_input', with: @profile.address
      fill_in 'cat_exp_input', with: @profile.cat_exp
      find('#profile_family_type').find("option[value='2']").select_option
      find('#profile_house_env').find("option[value='2']").select_option
      fill_in 'my_cats_input', with: @profile.my_cats
      fill_in 'introduction_input', with: @profile.introduction
      attach_file 'profile_user_image', 'public/images/test_image.png'
      # 「保存」ボタンをクリックすると、プロフィールモデルのレコードが１上がっていることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 先ほど保存したプロフィール画像がヘッダーに存在することを確認する
      within('ul', class: 'user-menu') do
        expect(page).to have_selector('img')
      end
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
    end

    it '画像をアップロードしなくても入力すればプロフィール新規登録ができてトップページへ遷移する' do
      # ユーザー新規登録
      sign_up(@user)
      # 現在のページがプロフィール新規作成ページであることを確認する
      expect(current_path).to eq(new_profile_path)
      # プロフィール情報を入力する(セレクトボックスはchromedriverが関数エラーを起こすため物理的に数字を入れる)
      find('#profile_age').find("option[value='2']").select_option
      fill_in 'job_input', with: @profile.job
      fill_in 'skills_input', with: @profile.skills
      fill_in 'address_input', with: @profile.address
      fill_in 'cat_exp_input', with: @profile.cat_exp
      find('#profile_family_type').find("option[value='2']").select_option
      find('#profile_house_env').find("option[value='2']").select_option
      fill_in 'my_cats_input', with: @profile.my_cats
      fill_in 'introduction_input', with: @profile.introduction
      # 「保存」ボタンをクリックすると、プロフィールモデルのレコードが１上がっていることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ユーザーのニックネームの頭文字がヘッダーに存在することを確認する
      within('ul', class: 'user-menu') do
        expect(page).to have_content(@user.nickname.slice(0).to_s)
      end
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
    end

    it '一つでも項目に変更があれば入力すればプロフィール新規登録ができてトップページへ遷移する' do
      # ユーザー新規登録
      sign_up(@user)
      # 現在のページがプロフィール新規作成ページであることを確認する
      expect(current_path).to eq(new_profile_path)
      # プロフィール情報を１つだけ入力する
      fill_in 'job_input', with: @profile.job
      # 「保存」ボタンをクリックすると、プロフィールモデルのレコードが１上がっていることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ユーザーのニックネームの頭文字がヘッダーに存在することを確認する
      within('ul', class: 'user-menu') do
        expect(page).to have_content(@user.nickname.slice(0).to_s)
      end
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end

    it '画像のアップロードだけでもプロフィール新規登録ができてトップページへ遷移する' do
      # ユーザー新規登録
      sign_up(@user)
      # 現在のページがプロフィール新規作成ページであることを確認する
      expect(current_path).to eq(new_profile_path)
      # 画像だけをアップロードする
      attach_file 'profile_user_image', 'public/images/test_image.png'
      # 「保存」ボタンをクリックすると、プロフィールモデルのレコードが１上がっていることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ユーザーのニックネームの頭文字がヘッダーに存在することを確認する
      within('ul', class: 'user-menu') do
        expect(page).to have_selector('img')
      end
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'プロフィール新規登録ができないとき' do
    it '何も入力しないままではプロフィールは保存されず、そのままトップページに遷移する' do
      # ユーザー新規登録
      sign_up(@user)
      # 現在のページがプロフィール新規作成ページであることを確認する
      expect(current_path).to eq(new_profile_path)
      # 「保存」ボタンをクリックしても、プロフィールモデルのレコードが増えていないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(0)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # ユーザーのニックネームの頭文字がヘッダーに存在することを確認する
      within('ul', class: 'user-menu') do
        expect(page).to have_content(@user.nickname.slice(0).to_s)
      end
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end
