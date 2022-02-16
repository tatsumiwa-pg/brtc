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


RSpec.describe 'プロフィール詳細表示', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user_id: @user.id)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @consultation2 = FactoryBot.create(:consultation, user_id: @user2.id)
    @cons_comment = FactoryBot.create(:cons_comment, user_id: @user.id, consultation_id: @consultation.id)
    @cons_comment2 = FactoryBot.create(:cons_comment, user_id: @user2.id, consultation_id: @consultation2.id)
    @answer = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @answer2 = FactoryBot.create(:answer, user_id: @user.id, consultation_id: @consultation2.id)
    @ans_comment = FactoryBot.create(:ans_comment, user_id: @user.id, answer_id: @answer.id)
    @ans_comment2 = FactoryBot.create(:ans_comment, user_id: @user2.id, answer_id: @answer2.id)
    @reconciliation = FactoryBot.create(:reconciliation, consultation_id: @consultation.id)
    @reconciliation2 = FactoryBot.create(:reconciliation, consultation_id: @consultation2.id)
    @review = FactoryBot.create(:review, point: 3, answer_id: @answer2.id)
    @review2 = FactoryBot.create(:review, point: 2, answer_id: @answer.id)
  end

  context 'プロフィールがある場合' do
    it 'ヘッダーから自身のプロフィール詳細ページへ遷移できる' do
      # ログインする
      sign_in(@user)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
      # リストの中に自身のプロフィール詳細表示ページへ遷移するためのボタンがあることを確認する
      within('ul', class: 'user-menu-lists') do
        expect(page).to have_selector('a', text: 'マイページへ')
      end
      # 自身のプロフィール詳細表示ページへ遷移するためのボタンをクリックする
      find('a', text: 'マイページへ').click

      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 自身のプロフィール詳細ページに評価の数が表示されていることを確認する
      within('#review-3') do
        expect(1).to eq @user.reviews.where(point: 3).size
      end
      within('#review-2') do
        expect(0).to eq @user.reviews.where(point: 2).size
      end
      within('#review-1') do
        expect(0).to eq @user.reviews.where(point: 1).size
      end
      # 過去に投稿した相談件数が表示されている
      within('#cons_count') do
        expect(1).to eq @user.consultations.size
      end
      # 過去に投稿した相談のタイトルが表示されている
      within('div', class:'consultation-list') do
        expect(page).to have_content(@consultation.cons_title)
      end
      # 和解済みの相談には「済」マークがタイトル横に表示されている
      within('div', class:'consultations', match: :first) do
        expect(page).to have_selector('#wakaizumi_img')
      end
      # 過去に投稿した回答件数が表示されている
      within('#ans_count') do
        expect(1).to eq @user.answers.size
      end
      # 過去に投稿した回答のタイトルが表示されている
      within('div', class:'answer-list') do
        expect(page).to have_content(@answer2.ans_title)
      end
      # 評価された回答には、その評価のマークが表示されている
      within('p', class: 'ans-review') do
        expect(page.all('img', class: 'review-image').count).to eq @review.point
      end

      
      # 登録してあるユーザーニックネームが表示されている
      within('h2', class: 'profile-title') do
        expect(page).to have_content(@user.nickname)
      end
      # 登録してあるプロフィール情報が表示されている（画像）
      expect(page).to have_selector('img', class:'user-image')
      # プロフィール画像の下に「編集」ボタンが表示されている
      within('div', class:'button-box-top') do
        expect(page).to have_selector('a', text:'編集')
      end
      # 登録してあるプロフィール情報が表示されている（年齢）
      within('#profile_age') do
        expect(page).to have_content(@profile.age.name)
      end
      # 登録してあるプロフィール情報が表示されている（職業）
      within('#profile_job') do
        expect(page).to have_content(@profile.job)
      end
      # 登録してあるプロフィール情報が表示されている（保有資格）
      within('#profile_skills') do
        expect(page).to have_content(@profile.skills)
      end
      # 登録してあるプロフィール情報が表示されている（住所）
      within('#profile_address') do
        expect(page).to have_content(@profile.address)
      end
      # 登録してあるプロフィール情報が表示されている（ﾈｺ歴）
      within('#profile_cat_exp') do
        expect(page).to have_content(@profile.cat_exp)
      end
      # 登録してあるプロフィール情報が表示されている（家族構成）
      within('#profile_family_type') do
        expect(page).to have_content(@profile.family_type.name)
      end
      # 登録してあるプロフィール情報が表示されている（住環境）
      within('#profile_house_env') do
        expect(page).to have_content(@profile.house_env.name)
      end
      # 登録してあるプロフィール情報が表示されている（わたしのﾈｺ）
      within('#profile_my_cats') do
        expect(page).to have_content(@profile.my_cats)
      end
      # 登録してあるプロフィール情報が表示されている（自己紹介）
      within('#profile_introduction') do
        expect(page).to have_content(@profile.introduction)
      end
      # 画面下部に「編集」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'編集')
      end
      # 画面下部に「一覧へ」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'一覧へ')
      end
      # 画面下部に「戻る」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'戻る')
      end
    end

    it '他のリンクから遷移しても問題なく自身のプロフィール詳細ページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談一覧にある自身のユーザーニックネームをクリックする
      find('a', text: @consultation.user.nickname, match: :first).click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 和解済みの際に表示されるユーザーアイコンをクリックする
      find('a', class:'consultation-user-link').click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # コメント欄の自分のコメントから、自身のユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # コメントを入力する
      fill_in 'cons_comment[cons_c_text]', with: 'テスト'
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 相談詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content(@cons_c_text)
      # 先ほど保存した内容の中から、ユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメント欄の自分のコメントから、自身のユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメントを入力する
      fill_in 'ans_comment[ans_c_text]', with: 'テスト'
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 回答詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content(@ans_c_text)
      # 回答詳細表示ページには先ほど保存した内容の存在する（ユーザーニックネーム）
      within('div#comments') do
       find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
    end
    
    it '他のユーザーのニックネームをクリックすると、そのユーザーのプロフィール詳細表示ページへ遷移できる' do
      # ログインする
      sign_in(@user2)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 他のユーザーのニックネームをクリックする
      find('a', text: @user.nickname).click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")

      # プロフィール詳細ページに該当ユーザーの評価の数が表示されていることを確認する
      within('#review-3') do
        expect(1).to eq @user.reviews.where(point: 3).size
      end
      within('#review-2') do
        expect(0).to eq @user.reviews.where(point: 2).size
      end
      within('#review-1') do
        expect(0).to eq @user.reviews.where(point: 1).size
      end
      # 過去に投稿した相談件数が表示されている
      within('#cons_count') do
        expect(1).to eq @user.consultations.size
      end
      # 過去に投稿した相談のタイトルが表示されている
      within('div', class:'consultation-list') do
        expect(page).to have_content(@consultation.cons_title)
      end
      # 和解済みの相談には「済」マークがタイトル横に表示されている
      within('div', class:'consultations', match: :first) do
        expect(page).to have_selector('#wakaizumi_img')
      end
      # 過去に投稿した回答件数が表示されている
      within('#ans_count') do
        expect(1).to eq @user.answers.size
      end
      # 過去に投稿した回答のタイトルが表示されている
      within('div', class:'answer-list') do
        expect(page).to have_content(@answer2.ans_title)
      end
      # 評価された回答には、その評価のマークが表示されている
      within('p', class: 'ans-review') do
        expect(page.all('img', class: 'review-image').count).to eq @review.point
      end

      # 該当ユーザーのユーザーニックネームが表示されている
      within('h2', class: 'profile-title') do
        expect(page).to have_content(@user.nickname)
      end
      # 該当ユーザーのプロフィール情報が表示されている（画像）
      expect(page).to have_selector('img', class:'user-image')
      # プロフィール画像の下に「編集」ボタンが表示されていない
      expect(page).to have_no_selector('div', class:'button-box-top')
      # 該当ユーザーのプロフィール情報が表示されている（年齢）
      within('#profile_age') do
        expect(page).to have_content(@profile.age.name)
      end
      # 該当ユーザーのプロフィール情報が表示されている（職業）
      within('#profile_job') do
        expect(page).to have_content(@profile.job)
      end
      # 該当ユーザーのプロフィール情報が表示されている（保有資格）
      within('#profile_skills') do
        expect(page).to have_content(@profile.skills)
      end
      # 該当ユーザーのプロフィール情報が表示されている（住所）
      within('#profile_address') do
        expect(page).to have_content(@profile.address)
      end
      # 該当ユーザーのプロフィール情報が表示されている（ﾈｺ歴）
      within('#profile_cat_exp') do
        expect(page).to have_content(@profile.cat_exp)
      end
      # 該当ユーザーのプロフィール情報が表示されている（家族構成）
      within('#profile_family_type') do
        expect(page).to have_content(@profile.family_type.name)
      end
      # 該当ユーザーのプロフィール情報が表示されている（住環境）
      within('#profile_house_env') do
        expect(page).to have_content(@profile.house_env.name)
      end
      # 該当ユーザーのプロフィール情報が表示されている（わたしのﾈｺ）
      within('#profile_my_cats') do
        expect(page).to have_content(@profile.my_cats)
      end
      # 該当ユーザーのプロフィール情報が表示されている（自己紹介）
      within('#profile_introduction') do
        expect(page).to have_content(@profile.introduction)
      end
      # 画面下部に「編集」ボタンが表示されていない
      within('div', class:'button-box') do
        expect(page).to have_no_selector('a', text:'編集')
      end
      # 画面下部に「一覧へ」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'一覧へ')
      end
      # 画面下部に「戻る」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'戻る')
      end
    end

    it '他のリンクから遷移しても問題なく該当ユーザーのプロフィール詳細ページへ遷移する' do
      # ログインする
      sign_in(@user2)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談一覧にある他のユーザーのニックネームをクリックする
      find('a', text: @consultation.user.nickname, match: :first).click
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 和解済みの際に表示されるユーザーアイコンをクリックする
      find('a', class:'consultation-user-link').click
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # コメント欄のコメントから、該当ユーザーのニックネームをクリックする
      within('div#comments') do
        find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメント欄のコメントから、該当ユーザーのニックネームをクリックする
      within('div#comments') do
        find('a', text: @user.nickname, match: :first).click
      end
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user.nickname}さんのプロフィール")
    end

    it 'ログアウト状態ではユーザーのプロフィール詳細表示ページへ遷移できず、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      find('a', text: @consultation.user.nickname, match: :first).click
      # 現在のページがログインページであることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'プロフィールがない場合' do
    it 'ヘッダーから自身の初期プロフィール詳細ページへ遷移できる' do
      # ログインする
      sign_in(@user2)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 隠されたリストを表示するためのボタンをクリックする
      find('#user_image').click
      # 隠されたリストが表示されたことを確認する
      expect(page).to have_selector('ul', class: 'user-menu-lists')
      # リストの中に自身のプロフィール詳細表示ページへ遷移するためのボタンがあることを確認する
      within('ul', class: 'user-menu-lists') do
        expect(page).to have_selector('a', text: 'マイページへ')
      end
      # 自身のプロフィール詳細表示ページへ遷移するためのボタンをクリックする
      find('a', text: 'マイページへ').click

      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 自身のプロフィール詳細ページに評価の数が表示されていることを確認する
      within('#review-3') do
        expect(0).to eq @user2.reviews.where(point: 3).size
      end
      within('#review-2') do
        expect(1).to eq @user2.reviews.where(point: 2).size
      end
      within('#review-1') do
        expect(0).to eq @user2.reviews.where(point: 1).size
      end
      # 過去に投稿した相談件数が表示されている
      within('#cons_count') do
        expect(1).to eq @user2.consultations.size
      end
      # 過去に投稿した相談のタイトルが表示されている
      within('div', class:'consultation-list') do
        expect(page).to have_content(@consultation2.cons_title)
      end
      # 和解済みの相談には「済」マークがタイトル横に表示されている
      within('div', class:'consultations', match: :first) do
        expect(page).to have_selector('#wakaizumi_img')
      end
      # 過去に投稿した回答件数が表示されている
      within('#ans_count') do
        expect(1).to eq @user2.answers.size
      end
      # 過去に投稿した回答のタイトルが表示されている
      within('div', class:'answer-list') do
        expect(page).to have_content(@answer.ans_title)
      end
      # 評価された回答には、その評価のマークが表示されている
      within('p', class: 'ans-review') do
        expect(page.all('img', class: 'review-image').count).to eq @review2.point
      end
      
      # 登録してあるユーザーニックネームが表示されている
      within('h2', class: 'profile-title') do
        expect(page).to have_content(@user2.nickname)
      end
      # プロフィール画像がない場合の表示があることを確認する（画像）
      expect(page).to have_selector('p', class: 'no-images')
      # プロフィール画像の下に「編集」ボタンが表示されている
      within('div', class:'button-box-top') do
        expect(page).to have_selector('a', text:'編集')
      end
      # 登録してあるプロフィール情報が表示されている（年齢）
      within('#profile_age') do
        expect(page).to have_content('未選択')
      end
      # 登録してあるプロフィール情報が表示されている（職業）
      within('#profile_job') do
        expect(page).to have_content('未記入')
      end
      # 登録してあるプロフィール情報が表示されている（保有資格）
      within('#profile_skills') do
        expect(page).to have_content('未記入')
      end
      # 登録してあるプロフィール情報が表示されている（住所）
      within('#profile_address') do
        expect(page).to have_content('未記入')
      end
      # 登録してあるプロフィール情報が表示されている（ﾈｺ歴）
      within('#profile_cat_exp') do
        expect(page).to have_content('未記入')
      end
      # 登録してあるプロフィール情報が表示されている（家族構成）
      within('#profile_family_type') do
        expect(page).to have_content('未選択')
      end
      # 登録してあるプロフィール情報が表示されている（住環境）
      within('#profile_house_env') do
        expect(page).to have_content('未選択')
      end
      # 登録してあるプロフィール情報が表示されている（わたしのﾈｺ）
      within('#profile_my_cats') do
        expect(page).to have_content('未記入')
      end
      # 登録してあるプロフィール情報が表示されている（自己紹介）
      within('#profile_introduction') do
        expect(page).to have_content('未記入')
      end
      # 画面下部に「編集」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'編集')
      end
      # 画面下部に「一覧へ」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'一覧へ')
      end
      # 画面下部に「戻る」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'戻る')
      end
    end

    it '他のリンクから遷移しても問題なく自身の初期プロフィール詳細ページへ遷移する' do
      # ログインする
      sign_in(@user2)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談一覧にある自身のユーザーニックネームをクリックする
      find('a', text: @consultation2.user.nickname, match: :first).click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # 和解済みの際に表示されるユーザーアイコンをクリックする
      find('a', class:'consultation-user-link').click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # コメント欄の自分のコメントから、自身のユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # コメントを入力する
      fill_in 'cons_comment[cons_c_text]', with: 'テスト'
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 相談詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content('テスト')
      # 先ほど保存した内容の中から、ユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer2.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer2.id)
      # コメント欄の自分のコメントから、自身のユーザーニックネームをクリックする
      within('div#comments') do
        find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer2.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer2.id)
      # コメントを入力する
      fill_in 'ans_comment[ans_c_text]', with: 'テスト'
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 回答詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content('テスト')
      # 回答詳細表示ページには先ほど保存した内容の存在する（ユーザーニックネーム）
      within('div#comments') do
       find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
    end

    it '他のユーザーのニックネームをクリックすると、そのユーザーの初期プロフィール詳細表示ページへ遷移できる' do
      # ログインする
      sign_in(@user)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 他のユーザーのニックネームをクリックする
      find('a', text: @user2.nickname).click
      # 現在のページが自身のプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)

      # プロフィール詳細ページに該当ユーザーの評価の数が表示されていることを確認する
      within('#review-3') do
        expect(0).to eq @user2.reviews.where(point: 3).size
      end
      within('#review-2') do
        expect(1).to eq @user2.reviews.where(point: 2).size
      end
      within('#review-1') do
        expect(0).to eq @user2.reviews.where(point: 1).size
      end
      # 過去に投稿した相談件数が表示されている
      within('#cons_count') do
        expect(1).to eq @user2.consultations.size
      end
      # 過去に投稿した相談のタイトルが表示されている
      within('div', class:'consultation-list') do
        expect(page).to have_content(@consultation2.cons_title)
      end
      # 和解済みの相談には「済」マークがタイトル横に表示されている
      within('div', class:'consultations', match: :first) do
        expect(page).to have_selector('#wakaizumi_img')
      end
      # 過去に投稿した回答件数が表示されている
      within('#ans_count') do
        expect(1).to eq @user2.answers.size
      end
      # 過去に投稿した回答のタイトルが表示されている
      within('div', class:'answer-list') do
        expect(page).to have_content(@answer.ans_title)
      end
      # 評価された回答には、その評価のマークが表示されている
      within('p', class: 'ans-review') do
        expect(page.all('img', class: 'review-image').count).to eq @review2.point
      end

      # 該当ユーザーのユーザーニックネームが表示されている
      within('h2', class: 'profile-title') do
        expect(page).to have_content(@user2.nickname)
      end
      # プロフィール画像がない場合の表示があることを確認する（画像）
      expect(page).to have_selector('p', class: 'no-images')
      # プロフィール画像の下に「編集」ボタンが表示されていないことを確認する
      expect(page).to have_no_selector('div', class:'button-box-top')
      # 初期プロフィール情報が表示されている（年齢）
      within('#profile_age') do
        expect(page).to have_content('未選択')
      end
      # 初期プロフィール情報が表示されている（職業）
      within('#profile_job') do
        expect(page).to have_content('未記入')
      end
      # 初期プロフィール情報が表示されている（保有資格）
      within('#profile_skills') do
        expect(page).to have_content('未記入')
      end
      # 初期プロフィール情報が表示されている（住所）
      within('#profile_address') do
        expect(page).to have_content('未記入')
      end
      # 初期プロフィール情報が表示されている（ﾈｺ歴）
      within('#profile_cat_exp') do
        expect(page).to have_content('未記入')
      end
      # 初期プロフィール情報が表示されている（家族構成）
      within('#profile_family_type') do
        expect(page).to have_content('未選択')
      end
      # 初期プロフィール情報が表示されている（住環境）
      within('#profile_house_env') do
        expect(page).to have_content('未選択')
      end
      # 初期プロフィール情報が表示されている（わたしのﾈｺ）
      within('#profile_my_cats') do
        expect(page).to have_content('未記入')
      end
      # 初期プロフィール情報が表示されている（自己紹介）
      within('#profile_introduction') do
        expect(page).to have_content('未記入')
      end
      # 画面下部に「編集」ボタンが表示されていないことを確認する
      within('div', class:'button-box') do
        expect(page).to have_no_selector('a', text:'編集')
      end
      # 画面下部に「一覧へ」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'一覧へ')
      end
      # 画面下部に「戻る」ボタンが表示されている
      within('div', class:'button-box') do
        expect(page).to have_selector('a', text:'戻る')
      end
    end

    it '他のリンクから遷移しても問題なく該当ユーザーの初期プロフィール詳細ページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談一覧にある他のユーザーのニックネームをクリックする
      find('a', text: @consultation2.user.nickname, match: :first).click
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # 和解済みの際に表示されるユーザーアイコンをクリックする
      find('a', class:'consultation-user-link').click
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(page).to have_content("#{@user2.nickname}さんのプロフィール")
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # コメント欄のコメントから、該当ユーザーのニックネームをクリックする
      within('div#comments') do
        find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
      # 「一覧へ」ボタンを押す
      find('a', text: '一覧へ').click

      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @consultation2.cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation2.id)
      # 回答一覧の中から最初の回答をクリックする
      find("a#answer_box_sub_#{@answer2.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer2.id)
      # コメント欄のコメントから、該当ユーザーのニックネームをクリックする
      within('div#comments') do
        find('a', text: @user2.nickname, match: :first).click
      end
      # 現在のページが該当ユーザーのプロフィール詳細表示ページであることを確認する
      expect(current_path).to eq default_profile_path(@user2.id)
    end
    
    it 'ログアウト状態ではユーザーのプロフィール詳細表示ページへ遷移できず、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      find('a', text: @consultation2.user.nickname, match: :first).click
      # 現在のページがログインページであることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end