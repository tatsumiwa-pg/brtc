require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    @answer = FactoryBot.build(:answer)
  end

  context '回答情報の入力内容に問題がない場合' do
    it 'すべての項目が正しく入力されていれば回答を投稿できる' do
      expect(@answer).to be_valid
    end
    it 'imageがカラでも回答を投稿できる' do
      @answer.image = nil
      expect(@answer).to be_valid
    end
  end

  context '回答情報の入力内容に問題がある場合' do
    it 'ans_titleがカラではユーザー登録できない' do
      @answer.ans_title = ''
      @answer.valid?
      expect(@answer.errors.full_messages).to include("Ans title can't be blank")
    end
    it 'cons_titleが40文字を超過した場合は登録できない' do
      @answer.ans_title = '12345678901234567890123456789012345678901'
      @answer.valid?
      expect(@answer.errors.full_messages).to include('Ans title is too long (maximum is 40 characters)')
    end
    it 'ans_textがカラではユーザー登録できない' do
      @answer.ans_text = ''
      @answer.valid?
      expect(@answer.errors.full_messages).to include("Ans text can't be blank")
    end
    it 'ans_textが2000文字を超過した場合は登録できない' do
      @answer.ans_text = Faker::Lorem.characters(number: 2001)
      @answer.valid?
      expect(@answer.errors.full_messages).to include('Ans text is too long (maximum is 2000 characters)')
    end
    it 'userが存在しなければ登録できない' do
      @answer.user = nil
      @answer.valid?
      expect(@answer.errors.full_messages).to include('User must exist')
    end
    it 'consultationが存在しなければ登録できない' do
      @answer.consultation = nil
      @answer.valid?
      expect(@answer.errors.full_messages).to include('Consultation must exist')
    end
  end
end
