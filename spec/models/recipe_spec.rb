require 'rails_helper'
describe Recipe do
  describe '#create' do
    it "nameとmaterial、textがあれば登録できること" do
      user = build(:user)
      recipe = user.recipes.build(
        name: "パンケーキ",
        material: "●小麦粉 100g",
        text: "ボウルにＡをふるい入れ、泡立て器で混ぜる。",
        user_id: "1"
      )
      expect(recipe).to be_valid
    end
    it "nameが空では登録できないこと" do
      user = build(:user)
      recipe = user.recipes.build(
        name: "",
        material: "●小麦粉 100g",
        text: "ボウルにＡをふるい入れ、泡立て器で混ぜる。",
        user_id: "1"
      )
      recipe.valid?
      expect(recipe.errors[:name]).to include("を入力してください")
    end
    it "materialが空では登録できないこと" do
      user = build(:user)
      recipe = user.recipes.build(
        name: "パンケーキ",
        material: "",
        text: "ボウルにＡをふるい入れ、泡立て器で混ぜる。",
        user_id: "1"
      )
      recipe.valid?
      expect(recipe.errors[:material]).to include("を入力してください")
    end
    it "textが空では登録できないこと" do
      user = build(:user)
      recipe = user.recipes.build(
        name: "パンケーキ",
        material: "●小麦粉 100g",
        text: "",
        user_id: "1"
      )
      recipe.valid?
      expect(recipe.errors[:text]).to include("を入力してください")
    end
  end
end