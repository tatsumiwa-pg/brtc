require 'rails_helper'

RSpec.describe '相談新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.build(:consultation, category_id: 1, user_id: @user.id)
  end

  context '相談の新規登録ができるとき' do
    it '正しい情報を入力して相談の新規登録ができてトップページへ遷移する' do
      # ログインする
      sign_in(@user)
      # トップページに新規登録ページへと遷移するボタンがあることを確認する
      expect(page).to have_content('相談する')
      # 相談新規投稿ページへ移動する
      find('a', text: '相談する').click
      # 相談情報を入力する
      fill_in 'cons-title', with: @consultation.cons_title
      find('option[value="1"]').select_option
      fill_in 'cons-summary', with: @consultation.summary
      fill_in 'cons-situation', with: @consultation.situation
      fill_in 'cons-problem', with: @consultation.problem
      attach_file 'cons-image', 'public/images/test_image.png'
      # 送信ボタンを押すと相談モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Consultation.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容の相談が存在する（タイトル）
      expect(page).to have_content(@consultation.cons_title)
      # トップページには先ほど投稿した内容の相談が存在する（ニックネーム）
      expect(page).to have_content(@consultation.user.nickname)
      # トップページには先ほど投稿した内容の相談が存在する（カテゴリー）
      expect(page).to have_content(@consultation.category.name)
    end

    it '画像がなくても正しいを入力すれば相談の新規登録ができてトップページへ遷移する' do
      # ログインする
      sign_in(@user)
      # トップページに新規登録ページへと遷移するボタンがあることを確認する
      expect(page).to have_content('相談する')
      # 相談新規投稿ページへ移動する
      find('a', text: '相談する').click
      # 相談情報を入力する
      fill_in 'cons-title', with: @consultation.cons_title
      find('option[value="1"]').select_option
      fill_in 'cons-summary', with: @consultation.summary
      fill_in 'cons-situation', with: @consultation.situation
      fill_in 'cons-problem', with: @consultation.problem
      # 送信ボタンを押すと相談モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Consultation.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容の相談が存在する（タイトル）
      expect(page).to have_content(@consultation.cons_title)
      # トップページには先ほど投稿した内容の相談が存在する（ニックネーム）
      expect(page).to have_content(@consultation.user.nickname)
      # トップページには先ほど投稿した内容の相談が存在する（カテゴリー）
      expect(page).to have_content(@consultation.category.name)
    end
  end

  context '相談の新規登録ができないとき' do
    it '誤った情報では相談を新規登録することができずに新規登録ページへ戻ってくる' do
      # ログインする
      sign_in(@user)
      # トップページに新規登録ページへと遷移するボタンがあることを確認する
      expect(page).to have_content('相談する')
      # 相談新規投稿ページへ移動する
      find('a', text: '相談する').click
      # 相談情報を入力する
      fill_in 'cons-title', with: ''
      find('option[value=""]').select_option
      fill_in 'cons-summary', with: ''
      fill_in 'cons-situation', with: ''
      fill_in 'cons-problem', with: ''
      # 送信ボタンを押してもConsultationモデルのカウントは上がらないことを確認する
      expect do
        find('input[name=commit]').click
      end.to change { Consultation.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_content('what happened?')
    end

    it 'ログアウトで相談投稿ページへ遷移しようとすると、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # トップページに新規登録ページへと遷移するボタンがあることを確認する
      expect(page).to have_content('相談する')
      # 相談新規投稿ページへ移動する
      find('a', text: '相談する').click
      # ログインページへリダイレクトすることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, user_id: @user.id)
    @cons_title = @consultation.cons_title
    @cons_category = @consultation.category.name
    @cons_summary = @consultation.summary
    @cons_situation = @consultation.situation
    @cons_problem = @consultation.problem
    @user2 = FactoryBot.create(:user)
  end

  context '相談の編集ができるとき' do
    it '正しい情報を入力すれば、ユーザー情報を変更できる' do
      # ログインする
      sign_in(@user)
      # トップページに相談詳細表示ページへ遷移するための相談タイトル（ボタン）があることを確認する
      expect(page).to have_link @cons_title
      # 詳細ページへ遷移する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 編集ページへ遷移するボタン（編集する）が存在すること（２つあるためクリックはしない）
      expect(page).to have_selector('a', text: '編集する')
      # 変更前の相談タイトルが表示されることを確認する
      expect(page).to have_content @cons_title
      # 変更前の相談カテゴリーが表示されることを確認する
      expect(page).to have_content @cons_category
      # 変更前の相談の要約（サマリー）が表示されることを確認する
      expect(page).to have_content @cons_summary
      # 変更前の相談の状況（シチュエーション）が表示されることを確認する
      expect(page).to have_content @cons_situation
      # 変更前の相談の問題が表示されることを確認する
      expect(page).to have_content @cons_problem
      # 変更前の同じ画像が表示されることを確認する
      expect(page).to have_selector "img[src$='test_image.png']"
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation.id)
      # 変更前の相談内容が表示されることを確認する
      expect(page).to have_field(id: 'cons-title', with: @cons_title)
      # 変更前の相談カテゴリーが表示されることを確認する
      expect(page).to have_select('consultation[category_id]', selected: @cons_category)
      # 変更前の相談の要約（サマリー）が表示されることを確認する
      expect(page).to have_field(id: 'cons-summary', with: @cons_summary)
      # 変更前の相談の状況（シチュエーション）が表示されることを確認する
      expect(page).to have_field(id: 'cons-situation', with: @cons_situation)
      # 変更前の相談の問題が表示されることを確認する
      expect(page).to have_field(id: 'cons-problem', with: @cons_problem)
      # 新しい相談情報を入力する（画像は変更しない）
      fill_in 'cons-title', with: 'テストタイトル（編集後）'
      find('option[value="2"]').select_option
      fill_in 'cons-summary', with: 'テストサマリー（編集後）'
      fill_in 'cons-situation', with: 'テストシチュエーション'
      fill_in 'cons-problem', with: 'テストプロブレム'
      # 送信ボタンを押す
      find('input[name="commit"]').click
      # 同じ相談の詳細表示ページへ遷移することを確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 変更後の相談タイトルが表示されることを確認する
      expect(page).to have_content('テストタイトル（編集後）')
      # 変更後の相談カテゴリーが表示されることを確認する
      expect(page).to have_content('運動・おもちゃ')
      # 変更後の相談の要約（サマリー）が表示されることを確認する
      expect(page).to have_content('テストサマリー（編集後）')
      # 変更後の相談の状況（シチュエーション）が表示されることを確認する
      expect(page).to have_content('テストシチュエーション')
      # 変更後の相談の問題が表示されることを確認する
      expect(page).to have_content('テストプロブレム')
      # 変更前と同じ画像が表示されることを確認する
      expect(page).to have_selector "img[src$='test_image.png']"
    end
  end

  context '相談の編集ができないとき' do
    it '情報に空欄があった場合、相談内容を変更することができずに相談編集ページへ戻ってくる' do
      # ログインする
      sign_in(@user)
      # トップページに相談詳細表示ページへ遷移するための相談タイトル（ボタン）があることを確認する
      expect(page).to have_link @cons_title
      # 詳細ページへ遷移する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 編集ページへ遷移するボタン（編集する）が存在すること（２つあるためクリックはしない）
      expect(page).to have_selector('a', text: '編集する')
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation.id)
      # 相談情報を空欄にする（画像は変更しない）
      fill_in 'cons-title', with: ''
      find('option[value=""]').select_option
      fill_in 'cons-summary', with: ''
      fill_in 'cons-situation', with: ''
      fill_in 'cons-problem', with: ''
      # 送信ボタンを押す
      find('input[name="commit"]').click
      # 相談ページへ戻されることを確認する
      expect(page).to have_content('edit your consultation!')
    end

    it '相談投稿者以外の別のユーザーが編集しようとしても、トップページへ遷移する' do
      # ログインする
      sign_in(@user2)
      # トップページに相談詳細表示ページへ遷移するための相談タイトル（ボタン）があることを確認する
      expect(page).to have_link @cons_title
      # 詳細ページへ遷移する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 編集ページへ遷移するボタン（編集する）が存在しないこと
      expect(page).to have_no_selector('a', text: '編集する')
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation.id)
      # トップページへ戻されることを確認する
      expect(current_path).to eq root_path
    end

    it 'ログアウト状態で編集画面へ遷移しようとしても、ログインページへ遷移する' do
      # Basic認証（ログインはしない）
      basic_auth(path)
      # トップページに相談詳細表示ページへ遷移するための相談タイトル（ボタン）があることを確認する
      expect(page).to have_link @cons_title
      # 詳細ページへ遷移する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 編集ページへ遷移するボタン（編集する）が存在しないこと
      expect(page).to have_no_selector('a', text: '編集する')
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation.id)
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation, category_id: 1, user_id: @user.id)
    @cons_title = @consultation.cons_title
  end

  context '相談の削除ができるとき' do
    it 'ログインしていれば、自身の投稿した相談の詳細ページから相談を削除できる' do
      # ログインする
      sign_in(@user)
      # トップページに相談詳細表示ページへ遷移するための相談タイトル（ボタン）があることを確認する
      expect(page).to have_link @cons_title
      # 詳細ページへ遷移する
      find('a', text: @cons_title).click
      # 現在のページが相談詳細ページであること確認する
      expect(current_path).to eq consultation_path(@consultation.id)
      # 削除ボタン（削除する）が存在すること
      expect(page).to have_selector('a', text: '削除する')
      # 削除ボタンを押し、確認メッセージで承認する
      page.accept_confirm do
        click_on :delete_btn
      end
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど削除した相談が存在しない（タイトル）
      expect(page).to have_no_content(@consultation.cons_title)
    end
  end
end
