require 'rails_helper'
describe User do
  describe '#create' do
    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "nicknameが空では登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailが空では登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordが空では登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "nicknameが7文字以上であれば登録できないこと" do
      user = build(:user, nickname: "aaaaaaa")
      user.valid?
      expect(user.errors[:nickname]).to include("は6文字以内で入力してください")
    end
    it "nicknameが6文字以下では登録できること" do
      user = build(:user, nickname: "aaaaaa")
      expect(user).to be_valid
    end
    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "hoge12", password_confirmation: "hoge12")
      expect(user).to be_valid
    end
    it "passwordが5文字以下であれば登録できないこと" do
      user = build(:user, password: "hoge0", password_confirmation: "hoge0")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end