require 'rails_helper'

RSpec.describe Reconciliation, type: :model do
  before do
    @reconciliation = FactoryBot.build(:reconciliation)
  end

  context '和解情報の入力内容に問題がない場合' do
    it 'すべての項目が正しく入力されていれば和解情報を保存できる' do
      expect(@reconciliation).to be_valid
    end
  end

  context '和解情報の入力内容に問題がある場合' do
    it 'rec_textがカラでは和解情報を登録できない' do
      @reconciliation.rec_text = ''
      @reconciliation.valid?
      expect(@reconciliation.errors.full_messages).to include("Rec text can't be blank")
    end
    it 'rec_textが40文字を超過した場合は登録できない' do
      @reconciliation.rec_text = Faker::Lorem.characters(number: 41)
      @reconciliation.valid?
      expect(@reconciliation.errors.full_messages).to include('Rec text is too long (maximum is 40 characters)')
    end
    it 'consultationが存在しなければ登録できない' do
      @reconciliation.consultation = nil
      @reconciliation.valid?
      expect(@reconciliation.errors.full_messages).to include('Consultation must exist')
    end
  end
end
