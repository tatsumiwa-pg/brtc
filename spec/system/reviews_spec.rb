require 'rails_helper'

RSpec.describe '回答へのレビュー', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @answer = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @answer2 = FactoryBot.create(:answer, user_id: @user2.id, consultation_id: @consultation.id)
    @ans_title = @answer.ans_title
    @ans_title2 = @answer2.ans_title
    @review2 = FactoryBot.create(:review, point: 1, answer_id: @answer2.id)
  end

  context '回答を評価できるとき' do
    it '所定のボタンをクリックすれば評価を送信でき、回答詳細表示ページに評価アイコンが表示される' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      within('div', class: 'content-wrap') do
        find('a', text: @cons_title, match: :first).click
      end
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 未評価の回答には評価の画像が存在しない
      within("a#answer_box_sub_#{@answer.id}") do
        expect(page.all('img', class: 'review-image').count).to eq 0
      end
      # 回答詳細表示ページへ移動する
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 「評価する」ボタンを押す
      find('#review_button1').click
      # 隠されたフォームが表示されることを確認する
      expect(page).to have_selector('div', class: 'float-message-box')
      # 「×」をクリックする
      find('#close_btn').click
      # フォームが非表示になることを確認する
      expect(page).to have_no_selector('div', class: 'float-message-box')
      # 再度「評価する」ボタンを押す
      find('#review_button1').click
      # 評価のラジオボタン（肉球アイコン）を押す（今回は３）
      find('#review_point_btn_3').click
      # フォームが非表示になったことを確認する
      expect(page).to have_no_selector('div', class: 'float-message-box')
      # 回答詳細表示ページには先ほど保存した評価が存在する（画像）
      expect(page.all('img', class: 'review-image').count).to eq 3
      # 回答詳細表示ページには「未評価」の文字がないことを確認する
      within('p#review_num1') do
        expect(page).to have_no_content('未評価')
      end
      # 相談詳細表示ページへ移動する
      find('a', text: '戻る').click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答情報の欄に先程の評価と同じだけ画像が挿入されている(今回は3)
      within("a#answer_box_sub_#{@answer.id}") do
        expect(page.all('img', class: 'review-image').count).to eq 3
      end
    end

    it '連続で評価を変えても内容が反映される' do
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 「評価する」ボタンを押す
      find('#review_button1').click
      # 隠されたフォームが表示されることを確認する
      expect(page).to have_selector('div', class: 'float-message-box')
      # 評価のラジオボタン（肉球アイコン）を押す（今回は３）
      find('#review_point_btn_3').click
      # フォームが非表示になったことを確認する
      expect(page).to have_no_selector('div', class: 'float-message-box')
      # 回答詳細表示ページには先ほど保存した評価が存在する（画像）
      expect(page.all('img', class: 'review-image').count).to eq 3
      # 回答詳細表示ページには「未評価」の文字がないことを確認する
      within('p#review_num1') do
        expect(page).to have_no_content('未評価')
      end
      # 再度「評価する」ボタンを押す
      find('#review_button1').click
      # 隠されたフォームが表示されることを確認する
      expect(page).to have_content('評価について')
      # 評価のラジオボタン（肉球アイコン）を押す（今回は2）
      find('#review_point_btn_2').click
      # フォームが非表示になったことを確認する
      expect(page).to have_no_selector('div', class: 'float-message-box')
      # 回答詳細表示ページには先ほど保存した評価が存在する（画像）
      within('p#review_num1') do
        expect(page.all('img', class: 'review-image').count).to eq 2
      end
      # 相談詳細表示ページへ移動する
      find('a', text: '戻る').click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答情報の欄に先程の評価と同じだけ画像が挿入されている(今回は2)
      within("a#answer_box_sub_#{@answer.id}") do
        expect(page.all('img', class: 'review-image').count).to eq 2
      end
    end

    it '既にある評価を変更することができる' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 未評価の回答には評価の画像が存在しない
      within("a#answer_box_sub_#{@answer.id}") do
        expect(page.all('img', class: 'review-image').count).to eq 0
      end
      # 既に評価のある回答には評価の画像が存在する
      within("a#answer_box_sub_#{@answer2.id}") do
        expect(page.all('img', class: 'review-image').count).to eq @review2.point
      end
      # 回答詳細表示ページへ移動する
      find("a#answer_box_sub_#{@answer2.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer2.id)
      # 回答詳細表示ページには既に付けられている評価の画像がある
      expect(page.all('img', class: 'review-image').count).to eq @review2.point
      # 「評価する」ボタンを押す
      find('#review_button1').click
      # 隠されたフォームが表示されることを確認する
      expect(page).to have_selector('div', class: 'float-message-box')
      # 「評価する」ボタンを押す
      find('#review_button1').click
      # 評価のラジオボタン（肉球アイコン）を押す（今回は３）
      find('#review_point_btn_3').click
      # フォームが非表示になったことを確認する
      expect(page).to have_no_selector('div', class: 'float-message-box')
      # 回答詳細表示ページには先ほど保存した評価が存在する（画像）
      sleep 0.1
      within('p#review_num1') do
        expect(page.all('img', class: 'review-image').count).to eq 3
      end
      # 相談詳細表示ページへ移動する
      find('a', text: '戻る').click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答情報の欄に先程の評価と同じだけ画像が挿入されている(今回は3)
      sleep 0.1
      within("a#answer_box_sub_#{@answer2.id}") do
        expect(page.all('img', class: 'review-image').count).to eq 3
      end
    end
  end

  context '回答を評価できないとき' do
    it '相談者以外は評価をつけることができない' do
      # ログインする
      sign_in(@user2)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 回答詳細表示ページに「評価する」ボタンがないことを確認する
      expect(page).to have_no_selector('review-button')
    end

    it 'ログアウト状態では評価をつけることができない' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 現在のページがトップページであることを確認する
      expect(current_path).to eq root_path
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find("a#answer_box_sub_#{@answer.id}").click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 回答詳細表示ページに「評価する」ボタンがないことを確認する
      expect(page).to have_no_selector('review-button')
    end
  end
end
