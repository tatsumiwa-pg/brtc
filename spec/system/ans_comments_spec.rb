require 'rails_helper'

RSpec.describe '回答へのコメント投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @answer = FactoryBot.create(:answer, user_id: @user.id, consultation_id: @consultation.id)
    @ans_title = @answer.ans_title
    @ans_comment = FactoryBot.build(:ans_comment)
    @ans_c_text = @ans_comment.ans_c_text
  end

  context 'コメントが正しく投稿できるとき' do
    it '正しい情報を入力すればコメントの登録ができて、回答詳細表示ページに表示される' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメントを入力する
      fill_in 'ans_comment[ans_c_text]', with: @ans_c_text
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 回答詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content(@ans_c_text)
      # 回答詳細表示ページには先ほど保存した内容の存在する（ユーザーニックネーム）
      within('div#comments') do
        expect(page).to have_selector('a', text: @user.nickname)
      end
      # 回答詳細表示ページには先ほど保存したコメントに対して「New」と表示される（投稿日時）
      expect(page).to have_content('New')
      # コメント一覧の現在のコメント数が相談に紐づくコメント数（更新後）と一致する
      within('p#comment_num') do
        expect(page).to have_content(@answer.ans_comments.size)
      end
      # 連続投稿しても投稿内容が反映されることを確認
      fill_in 'ans_comment[ans_c_text]', with: @ans_c_text
      find('input[name="commit"]').click
      expect(page).to have_content(@ans_c_text)
      within('p#comment_num') do
        expect(page).to have_content(@answer.ans_comments.size)
      end
    end

    it 'ページ遷移を繰り返しても問題なく投稿されたコメントが反映される' do
      # ログインする
      sign_in(@user)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 回答詳細表示ページへ移動する
      find('a', text: '戻る').click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 再度、回答詳細表示ページへ移動する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメントを入力する
      fill_in 'ans_comment[ans_c_text]', with: @ans_c_text
      # 「送信」ボタンを押す
      find('input[name="commit"]').click
      # 回答詳細表示ページには先ほど保存した内容が存在する（テキスト）
      expect(page).to have_content(@ans_c_text)
      # 回答詳細表示ページには先ほど保存した内容の存在する（ユーザーニックネーム）
      within('div#comments') do
        expect(page).to have_selector('a', text: @user.nickname)
      end
      # 回答詳細表示ページには先ほど保存したコメントに対して「New」と表示される（投稿日時）
      expect(page).to have_content('New')
      # コメント一覧の現在のコメント数が相談に紐づくコメント数（更新後）と一致する
      within('p#comment_num') do
        expect(page).to have_content(@answer.ans_comments.size)
      end
      # 連続投稿しても投稿内容が反映されることを確認
      fill_in 'ans_comment[ans_c_text]', with: @ans_c_text
      find('input[name="commit"]').click
      expect(page).to have_content(@ans_c_text)
      within('p#comment_num') do
        expect(page).to have_content(@answer.ans_comments.size)
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
      # 回答詳細表示ページへ移動する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # コメントを入力する
      fill_in 'ans_comment[ans_c_text]', with: ''
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
    end

    it 'ログアウト状態ではコメント投稿ができない' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # 相談詳細表示ページへ移動する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細表示ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 回答詳細表示ページへ移動する
      find('a', text: @ans_title).click
      # 現在のページが回答詳細表示ページであること確認する
      expect(current_path).to eq answer_path(@answer.id)
      # 相談詳細表示ページにはコメントのテキスト入力フォームがないことを確認する
      expect(page).to have_no_selector('ans_comment[name="ans_c_text"]')
      # 相談詳細表示ページには「※コメントをするにはログインが必要です」というメッセージがあることを確認する
      expect(page).to have_content('※コメントをするにはログインが必要です')
    end
  end
end
