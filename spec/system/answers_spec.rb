require 'rails_helper'

RSpec.describe "回答新規投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @ans_title = Faker::Lorem.characters(number: 1..40)
    @ans_text = Faker::Lorem.characters(number: 1..2000)
    @user2 = FactoryBot.create(:user)
  end

  context '相談の新規登録ができるとき' do
    it '正しい情報を入力すれば回答の新規登録ができて相談詳細表示画面へ遷移する' do
      # ログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '回答する')
      # 新規回答作成ページへ遷移するためのボタンをクリックする
      find('a', text: '回答する', match: :first).click
      # 現在のページが新規回答作成ページであること確認する
      expect(current_path).to eq new_consultation_answer_path(@consultation.id)
      # 回答情報を入力する
      fill_in 'answer[ans_title]', with: @ans_title
      fill_in 'answer[ans_text]', with: @ans_text
      attach_file 'ans-image', 'public/images/test_image.png'
      # 送信ボタンを押すと相談モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Answer.count }.by(1)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには先ほど投稿した内容の相談が存在する（タイトル）
      expect(page).to have_content(@ans_title)
      # 相談詳細表示ページには先ほど投稿した内容の相談が存在する（ユーザーニックネーム）
      expect(page).to have_content(@consultation.user.nickname)
    end

    it '画像がなくても回答の新規登録ができる' do
      # ログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '回答する')
      # 新規回答作成ページへ遷移するためのボタンをクリックする
      find('a', text: '回答する', match: :first).click
      # 現在のページが新規回答作成ページであること確認する
      expect(current_path).to eq new_consultation_answer_path(@consultation.id)
      # 回答情報を入力する（画像なし）
      fill_in 'answer[ans_title]', with: @ans_title
      fill_in 'answer[ans_text]', with: @ans_text
      # 送信ボタンを押すと相談モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Answer.count }.by(1)
      # 相談詳細表示ページへ遷移したことを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページには先ほど投稿した内容の相談が存在する（タイトル）
      expect(page).to have_content(@ans_title)
      # 相談詳細表示ページには先ほど投稿した内容の相談が存在する（ユーザーニックネーム）
      expect(page).to have_content(@consultation.user.nickname)
    end
  end
  
  context '回答の新規登録ができないとき' do
    it '誤った情報では回答を新規登録することができずに新規登録ページへ戻ってくる' do
      # ログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがあることを確認する
      expect(page).to have_selector('a', text: '回答する')
      # 新規回答作成ページへ遷移するためのボタンをクリックする
      find('a', text: '回答する', match: :first).click
      # 現在のページが新規回答作成ページであること確認する
      expect(current_path).to eq new_consultation_answer_path(@consultation.id)
      # 回答情報を入力する
      fill_in 'answer[ans_title]', with: ''
      fill_in 'answer[ans_text]', with: ''
      attach_file 'ans-image', 'public/images/test_image.png'
      # 送信ボタンを押してもAnswerモデルのカウントは上がらないことを確認する
      expect do
        find('input[name=commit]').click
      end.to change { Answer.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq consultation_answers_path(@consultation.id)
    end

    it '相談投稿者は自身の相談に対する回答投稿ページへ遷移しようとすると、元のページへ遷移する' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # URLを直接入力して、新規回答作成ページへ遷移しようとする
      visit new_consultation_answer_path(@consultation.id)
      # 相談詳細表示ページに戻されていること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
    end

    it 'ログアウト状態で回答投稿ページへ遷移しようとすると、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページに、新規回答作成ページへ遷移するためのボタンがないことを確認する
      expect(page).to have_no_selector('a', text: '回答する')
      # URLを直接入力して、新規回答作成ページへ遷移しようとする
      visit new_consultation_answer_path(@consultation.id)
      # ログインページにリダイレクトしていること確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end


RSpec.describe "詳細表示", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @answer = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @ans_title = @answer.ans_title
    @ans_text = @answer.ans_text
  end

  context '回答の詳細を確認する' do
    it 'ユーザーログインから回答詳細表示ページまで遷移' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 投稿された回答のタイトルと投稿者の名前があることを確認する
      expect(page).to have_selector('a', text: @ans_title)
      expect(page).to have_selector('a', text: @answer.user.nickname)
      # 回答詳細表示ページへ遷移する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 回答詳細表示ページには、投稿された回答の詳細情報があることを確認できる（タイトル）
      expect(page).to have_content(@ans_title)
      # 回答詳細表示ページには、投稿された回答の詳細情報があること確認できる（本文）
      expect(page).to have_content(@ans_text)
      # 回答詳細表示ページには、投稿された回答の詳細情報があること確認できる（画像）
      expect(page).to have_selector "img[src$='test_image.png']"
      # 回答詳細表示ページには、投稿された回答の詳細情報があること確認できる（投稿者名）
      expect(page).to have_content(@answer.user.nickname)
    end
  end
end