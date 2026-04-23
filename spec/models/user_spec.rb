require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      # 正常系（すべて揃っている状態）の基本データ
      @user_params = {
        nickname: 'test',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        last_name: '田高田',
        first_name: '誠',
        last_name_kana: 'タコウダ',
        first_name_kana: 'マコト',
        birth_date: '1930-01-01'
      }
    end

    context '新規登録できるとき' do
      it 'すべての項目の入力が存在すれば登録できる' do
        user = User.new(@user_params)
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user_params[:nickname] = ''
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user_params[:email] = ''
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user_params[:password] = ''
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'birth_dateが空では登録できない' do
        @user_params[:birth_date] = ''
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user_params[:last_name] = 'abc'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user_params[:first_name] = 'abc'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name_kanaが全角（カタカナ）でないと登録できない' do
        @user_params[:last_name_kana] = 'あいう'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
        @user_params[:first_name_kana] = 'あいう'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("First name kana is invalid")
      end

      it 'passwordが英語のみでは登録できない' do
        @user_params[:password] = 'abcdef'
        @user_params[:password_confirmation] = 'abcdef'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが数字のみでは登録できない' do
        @user_params[:password] = '123456'
        @user_params[:password_confirmation] = '123456'
        user = User.new(@user_params)
        user.valid?
        expect(user.errors.full_messages).to include("Password is invalid")
      end
    end
  end
end