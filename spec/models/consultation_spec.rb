require 'rails_helper'

RSpec.describe Consultation, type: :model do
  before do
    @consultation = FactoryBot.build(:consultation)
  end

  context '相談情報の入力内容に問題がない場合' do
    it 'すべての項目が正しく入力されていれば相談を投稿できる' do
      expect(@consultation).to be_valid
    end
    it 'imageがカラでも相談を投稿できる' do
      @consultation.image = nil
      expect(@consultation).to be_valid
    end
  end
  context '相談情報の入力内容に問題がある場合' do
    it 'cons_titleがカラではユーザー登録できない' do
      @consultation.cons_title = ''
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include("Cons title can't be blank")
    end
    it 'cons_titleが50文字を超過した場合は登録できない' do
      @consultation.cons_title = '123456789012345678901234567890123456789012345678901'
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include('Cons title is too long (maximum is 50 characters)')
    end
    it 'category_idがカラではユーザー登録できない' do
      @consultation.category_id = ''
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include("Category can't be blank")
    end
    it 'summaryが150文字を超過した場合は登録できない' do
      @consultation.summary = Faker::Lorem.characters(number: 151)
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include('Summary is too long (maximum is 150 characters)')
    end
    it 'situationがカラではユーザー登録できない' do
      @consultation.situation = ''
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include("Situation can't be blank")
    end
    it 'situationが2000文字を超過した場合は登録できない' do
      @consultation.situation = Faker::Lorem.characters(number: 2001)
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include('Situation is too long (maximum is 2000 characters)')
    end
    it 'problemがカラではユーザー登録できない' do
      @consultation.problem = ''
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include("Problem can't be blank")
    end
    it 'problemが2000文字を超過した場合は登録できない' do
      @consultation.problem = Faker::Lorem.characters(number: 2001)
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include('Problem is too long (maximum is 2000 characters)')
    end
    it 'userが存在しなければ登録できない' do
      @consultation.user = nil
      @consultation.valid?
      expect(@consultation.errors.full_messages).to include('User must exist')
    end
  end
end
