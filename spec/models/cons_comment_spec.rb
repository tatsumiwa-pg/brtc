require 'rails_helper'

RSpec.describe ConsComment, type: :model do
  before do
    @cons_comment = FactoryBot.build(:cons_comment)
  end

  context 'コメントの入力内容に問題がない場合' do
    it 'cons_c_textが正しく入力されていればコメントを保存できる' do
      expect(@cons_comment).to be_valid
    end
  end

  context 'コメントの入力内容に問題がある場合' do
    it 'cons_c_textがカラではコメントを保存できない' do
      @cons_comment.cons_c_text = ''
      @cons_comment.valid?
      expect(@cons_comment.errors.full_messages).to include("Cons c text can't be blank")
    end
    it 'cons_c_textが150文字を超過した場合は保存できない' do
      @cons_comment.cons_c_text = Faker::Lorem.characters(number: 151)
      @cons_comment.valid?
      expect(@cons_comment.errors.full_messages).to include('Cons c text is too long (maximum is 150 characters)')
    end
    it 'userが存在しなければ保存できない' do
      @cons_comment.user = nil
      @cons_comment.valid?
      expect(@cons_comment.errors.full_messages).to include('User must exist')
    end
    it 'consultationが存在しなければ登録できない' do
      @cons_comment.consultation = nil
      @cons_comment.valid?
      expect(@cons_comment.errors.full_messages).to include('Consultation must exist')
    end
  end
end
