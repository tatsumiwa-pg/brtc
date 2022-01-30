require 'rails_helper'

RSpec.describe '和解情報登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @answer = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @ans_title = @answer.ans_title
    @ans_user = @answer.user.nickname
    @rec_text = Faker::Lorem.characters(number: 1..40)
  end

  context '和解情報の登録ができるとき' do
    it '正しい情報を入力すれば和解情報の登録ができて相談詳細表示画面へ遷移する' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 投稿された回答のタイトルと投稿者の名前があることを確認する
      expect(page).to have_selector('a', text: @ans_title)
      expect(page).to have_selector('a', text: @answer.user.nickname)
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談編集ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '編集する')
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '和解する')
      # 和解情報登録ページへ遷移するためのボタンをクリックする
      find('a', text: '和解する', match: :first).click
      # 現在のページが和解情報登録ページであること確認する
      expect(current_path).to eq new_consultation_reconciliation_path(@consultation.id)
      # お礼のメッセージを入力する
      fill_in 'reconciliation[rec_text]', with: @rec_text
      # 「ﾈｺと和解した」ボタンを押すと和解情報モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Reconciliation.count }.by(1)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには先ほど保存した内容のテキストが存在する
      expect(page).to have_content(@rec_text)
      # 相談詳細表示ページには「済」のマークが表示されている
      expect(page).to have_selector "img[alt='wakaizumi']"
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # トップページに戻る
      visit root_path
      # 相談一覧表示ページ（トップページ）の「回答募集中」の相談一覧の中に先ほど和解情報を保存した相談の情報がないことを確認する
      within('div#list1') do
        expect(page).to have_no_selector('a', text: @cons_title)
      end
      # 相談一覧表示ページ（トップページ）の「和解済み」の相談一覧の中に先ほど和解情報を保存した相談の情報があることを確認する
      within('div#list2') do
        expect(page).to have_selector('a', text: @cons_title)
      end
      # ログアウトする
      find('a', text: 'ログアウト').click
      # 別ユーザーでログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
    end

    it 'rec_textがなくても自動的に「ありがとうございました」の文字が登録され、和解情報の保存ができる' do
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 投稿された回答のタイトルと投稿者の名前があることを確認する
      expect(page).to have_selector('a', text: @ans_title)
      expect(page).to have_selector('a', text: @answer.user.nickname)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '和解する')
      # 和解情報登録ページへ遷移するためのボタンをクリックする
      find('a', text: '和解する', match: :first).click
      # 現在のページが和解情報登録ページであること確認する
      expect(current_path).to eq new_consultation_reconciliation_path(@consultation.id)
      # お礼のメッセージを入力する
      fill_in 'reconciliation[rec_text]', with: ''
      # 「ﾈｺと和解した」ボタンを押すと和解情報モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Reconciliation.count }.by(1)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには「ありがとうございました」のテキストが存在する
      expect(page).to have_content('ありがとうございました')
      # 相談詳細表示ページには「済」のマークが表示されている
      expect(page).to have_selector "img[alt='wakaizumi']"
    end
  end
end

RSpec.describe '和解情報保存の失敗', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
  end

  context '和解情報保存ページへ遷移できない時' do
    it '相談投稿者は回答のまだない相談に対する和解情報保存ページへ遷移しようとすると、元のページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # 相談詳細表示ページに、相談を削除するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # URLを直接入力して、和解情報保存ページへ遷移しようとする
      visit new_consultation_reconciliation_path(@consultation.id)
      # 相談詳細表示ページに戻されていること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
    end

    it 'ログアウト状態で和解情報保存ページへ遷移しようとすると、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # URLを直接入力して、和解情報保存ページへ遷移しようとする
      visit new_consultation_reconciliation_path(@consultation.id)
      # ログインページにリダイレクトしていること確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '和解情報保存後の挙動（異常系）', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @answer = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @reconciliation = FactoryBot.create(:reconciliation, consultation_id: @consultation.id)
    @rec_text = @reconciliation.rec_text
  end

  context '和解済みの相談に対する操作の失敗' do
    it '既に和解情報がある相談の和解情報保存ページへ遷移しようとすると、元の相談詳細表示ページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには和解情報のテキストが存在する
      expect(page).to have_content(@rec_text)
      # 相談詳細表示ページには「済」のマークが表示されている
      expect(page).to have_selector "img[alt='wakaizumi']"
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # URLを直接入力して、和解情報登録ページへ遷移しようとする
      visit new_consultation_reconciliation_path(@consultation.id)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
    end

    it '既に和解情報がある相談の編集ページへ遷移しようとすると、元の相談詳細表示ページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには和解情報のテキストが存在する
      expect(page).to have_content(@rec_text)
      # 相談詳細表示ページには「済」のマークが表示されている
      expect(page).to have_selector "img[alt='wakaizumi']"
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # URLを直接入力して、和解情報登録ページへ遷移しようとする
      visit edit_consultation_path(@consultation.id)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
    end

    it '既に和解情報がある相談に対する新規回答投稿ページへ遷移しようとすると、元の相談詳細表示ページへ遷移する' do
      # ログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには和解情報のテキストが存在する
      expect(page).to have_content(@rec_text)
      # 相談詳細表示ページには「済」のマークが表示されている
      expect(page).to have_selector "img[alt='wakaizumi']"
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '削除する')
      # 相談詳細表示ページに、相談を編集するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '編集する')
      # 相談詳細表示ページに、和解情報登録ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '和解する')
      # URLを直接入力して、和解情報登録ページへ遷移しようとする
      visit new_consultation_answer_path(@consultation.id)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
    end
  end
end
