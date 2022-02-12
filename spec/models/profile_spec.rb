require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end

  context 'プロフィール情報の入力内容に問題がない場合' do
    it 'すべての項目が正しく入力されていれば相談を投稿できる' do
      expect(@profile).to be_valid
    end
    it 'user_imageがカラでも相談を投稿できる' do
      @profile.user_image = nil
      expect(@profile).to be_valid
    end
  end

  context 'プロフィール情報の入力内容に問題がある場合' do
    it 'age_idがカラではプロフィール登録できない' do
      @profile.age_id = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Age can't be blank")
    end
    it 'jobがカラではプロフィール登録できない' do
      @profile.job = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Job can't be blank")
    end
    it 'jobが100文字を超過した場合は登録できない' do
      @profile.job = Faker::Lorem.characters(number: 101)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('Job is too long (maximum is 100 characters)')
    end
    it 'skillsがカラではプロフィール登録できない' do
      @profile.skills = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Skills can't be blank")
    end
    it 'skillsが200文字を超過した場合は登録できない' do
      @profile.skills = Faker::Lorem.characters(number: 201)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('Skills is too long (maximum is 200 characters)')
    end
    it 'addressがカラではプロフィール登録できない' do
      @profile.address = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Address can't be blank")
    end
    it 'addressが50文字を超過した場合は登録できない' do
      @profile.address = Faker::Lorem.characters(number: 51)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('Address is too long (maximum is 50 characters)')
    end
    it 'cat_expがカラではプロフィール登録できない' do
      @profile.cat_exp = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Cat exp can't be blank")
    end
    it 'cat_expが200文字を超過した場合は登録できない' do
      @profile.cat_exp = Faker::Lorem.characters(number: 201)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('Cat exp is too long (maximum is 200 characters)')
    end
    it 'family_type_idがカラではプロフィール登録できない' do
      @profile.family_type_id = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Family type can't be blank")
    end
    it 'house_env_idがカラではプロフィール登録できない' do
      @profile.house_env_id = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("House env can't be blank")
    end
    it 'my_catsがカラではプロフィール登録できない' do
      @profile.my_cats = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("My cats can't be blank")
    end
    it 'my_catsが500文字を超過した場合は登録できない' do
      @profile.my_cats = Faker::Lorem.characters(number: 501)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('My cats is too long (maximum is 500 characters)')
    end
    it 'introductionがカラではプロフィール登録できない' do
      @profile.introduction = ''
      @profile.valid?
      expect(@profile.errors.full_messages).to include("Introduction can't be blank")
    end
    it 'introductionが1000文字を超過した場合は登録できない' do
      @profile.introduction = Faker::Lorem.characters(number: 1001)
      @profile.valid?
      expect(@profile.errors.full_messages).to include('Introduction is too long (maximum is 1000 characters)')
    end
    it 'userが存在しなければ登録できない' do
      @profile.user = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include('User must exist')
    end
  end
end
