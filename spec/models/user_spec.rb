require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = FactoryBot.build(:user)
    @user2 = FactoryBot.build(:user)
  end

  context 'ユーザー情報の入力内容に問題がない場合' do
    it 'すべての項目が正しく入力されていればユーザー登録できる' do
      expect(@user1).to be_valid
    end
    it 'deleted_atがカラでなくてもユーザー登録できる(論理削除ができる)' do
      @user1.deleted_at = '2022-01-16 09:14:29'
      expect(@user1).to be_valid
    end
  end
  context 'ユーザー情報の入力内容に問題がある場合' do
    it 'nicknameがカラではユーザー登録できない' do
      @user1.nickname = ''
      @user1.valid?
      expect(@user1.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'nicknameが40文字を超過した場合は登録できない' do
      @user1.nickname = '12345678901234567890123456789012345678901'
      @user1.valid?
      expect(@user1.errors.full_messages).to include('Nickname is too long (maximum is 40 characters)')
    end
    it '既に登録されているnicknameではユーザー登録できない' do
      @user1.save
      @user2.nickname = @user1.nickname
      @user2.valid?
      expect(@user2.errors.full_messages).to include('Nickname has already been taken')
    end
    it 'emailがカラではユーザー登録できない' do
      @user1.email = ''
      @user1.valid?
      expect(@user1.errors.full_messages).to include("Email can't be blank")
    end
    it '既に登録されているemailではユーザー登録できない' do
      @user1.save
      @user2.email = @user1.email
      @user2.valid?
      expect(@user2.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailに@が含まれていなければユーザー登録できない' do
      @user1.email = 'test.test.com'
      @user1.valid?
      expect(@user1.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordがカラではユーザー登録できない' do
      @user1.password = ''
      @user1.valid?
      expect(@user1.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが5文字以下ではではユーザー登録できない' do
      @user1.password = '1111a'
      @user1.valid?
      expect(@user1.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角英数字の２種類を含んでいなければユーザー登録できない1' do
      @user1.password = 'あああああ1'
      @user1.password_confirmation = 'あああああ1'
      @user1.valid?
      expect(@user1.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end
    it 'passwordが半角英数字の２種類を含んでいなければユーザー登録できない2' do
      @user2.password = 'あああああa'
      @user2.password_confirmation = 'あああああa'
      @user2.valid?
      expect(@user2.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end
    it 'passwordとpassword_confirmationが一致しなければユーザー登録できない' do
      @user1.password_confirmation = '11111a'
      @user1.valid?
      expect(@user1.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
