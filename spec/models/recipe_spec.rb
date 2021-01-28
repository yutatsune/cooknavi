require 'rails_helper'
describe Recipe do
  describe '#create' do
    it "nameとexplanationとmaterial、textがあれば登録できること" do
      recipe = build(:recipe)
      expect(recipe).to be_valid
    end
    it "nameが空では登録できないこと" do
      recipe = build(:recipe, name: "")
      recipe.valid?
      expect(recipe.errors[:name]).to include("を入力してください")
    end
    it "explanationが空では登録できないこと" do
      recipe = build(:recipe, explanation: "")
      recipe.valid?
      expect(recipe.errors[:explanation]).to include("を入力してください")
    end
    it "materialが空では登録できないこと" do
      recipe = build(:recipe, material: "")
      recipe.valid?
      expect(recipe.errors[:material]).to include("を入力してください")
    end
    it "textが空では登録できないこと" do
      recipe = build(:recipe, text: "")
      recipe.valid?
      expect(recipe.errors[:text]).to include("を入力してください")
    end
  end
end
