require 'rails_helper'

RSpec.describe AnsComment, type: :model do
  before do
    @ans_comment = FactoryBot.build(:ans_comment)
  end

  context 'コメントの入力内容に問題がない場合' do
    it 'ans_c_textが正しく入力されていればコメントを保存できる' do
      expect(@ans_comment).to be_valid
    end
  end

  context 'コメントの入力内容に問題がある場合' do
    it 'ans_c_textがカラではコメントを保存できない' do
      @ans_comment.ans_c_text = ''
      @ans_comment.valid?
      expect(@ans_comment.errors.full_messages).to include("Ans c text can't be blank")
    end
    it 'ans_c_textが150文字を超過した場合は保存できない' do
      @ans_comment.ans_c_text = Faker::Lorem.characters(number: 151)
      @ans_comment.valid?
      expect(@ans_comment.errors.full_messages).to include('Ans c text is too long (maximum is 150 characters)')
    end
    it 'userが存在しなければ保存できない' do
      @ans_comment.user = nil
      @ans_comment.valid?
      expect(@ans_comment.errors.full_messages).to include('User must exist')
    end
    it 'answerが存在しなければ登録できない' do
      @ans_comment.answer = nil
      @ans_comment.valid?
      expect(@ans_comment.errors.full_messages).to include('Answer must exist')
    end
  end
end
