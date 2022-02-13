require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  context '評価情報の入力内容に問題がない場合' do
    it '項目が正しく入力されていれば回答を投稿できる' do
      expect(@review).to be_valid
    end
  end

  context '評価情報の入力内容に問題がある場合' do
    it 'pointがカラではユーザー登録できない' do
      @review.point = ''
      @review.valid?
      expect(@review.errors.full_messages).to include("Point can't be blank")
    end
    it 'answerが存在しなければ登録できない' do
      @review.answer = nil
      @review.valid?
      expect(@review.errors.full_messages).to include('Answer must exist')
    end
  end
end
