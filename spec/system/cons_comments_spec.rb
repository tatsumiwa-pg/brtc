require 'rails_helper'

RSpec.describe "相談へのコメント投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @cons_comment = FactoryBot.build(:cons_comment)
    @cons_c_text = @cons_comment.cons_c_text
  end

  context 'コメントが正しく投稿できるとき' do
    it '正しい情報を入力すればコメントの登録ができて、相談詳細表示ページに表示される' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # コメントを入力する
      fill_in 'cons_comment[cons_c_text]', with: @cons_c_text
      # 「送信」ボタンを押すとConsCommentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ConsComment.count }.by(1)
      # 相談詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content(@cons_c_text)
      # 相談詳細表示ページには先ほど保存した内容の存在する（ユーザーニックネーム）
      within('div#comments') do
        expect(page).to have_selector('a', text: @user.nickname)
      end
      # 相談詳細表示ページには先ほど保存したコメントに対して「New」と表示される（投稿日時）
      expect(page).to have_content('New')
      # 相談詳細表示ページに、相談を削除するためのボタンがないことを確認する
      within('div#buttons1') do
        expect(page).to have_no_selector('a', text: '削除する')
      end
      within('div#buttons2') do
        expect(page).to have_no_selector('a', text: '削除する')
      end
    end
  end

  context 'コメントが投稿できないとき' do
    it 'テキストがカラでは何の処理も起こらない' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # コメントを入力する
      fill_in 'cons_comment[cons_c_text]', with: ''
      # 「送信」ボタンを押すとConsCommentモデルのカウントが上がらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ConsComment.count }.by(0)
      # 相談詳細表示ページにはカラのコメントが存在しない（ユーザーニックネーム）
      within('div#comments') do
        expect(page).to have_no_selector('a', text: @user.nickname)
      end
      # 相談詳細表示ページにはカラのコメントが存在しない（投稿日時）
      expect(page).to have_no_content('New')
      # 相談詳細表示ページに、相談を削除するためのボタンがあることを確認する
      within('div#buttons1') do
        expect(page).to have_selector('a', text: '削除する')
      end
      within('div#buttons2') do
        expect(page).to have_selector('a', text: '削除する')
      end
    end

    it 'ログアウト状態ではコメント投稿ができない' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 相談詳細表示ページにはコメントのテキスト入力フォームがないことを確認する
      expect(page).to have_no_selector('cons_comment[name="cons_c_text"]')
      # 相談詳細表示ページには「※コメントをするにはログインが必要です」というメッセージがあることを確認する
      expect(page).to have_content('※コメントをするにはログインが必要です')
    end
  end
end
