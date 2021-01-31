require 'rails_helper'
describe Material do
  describe '#create' do
    it "nameとpostcode、prefecture_code、address_city、address_building、explanation、latitude、longitudeを入れて登録できること" do
      material = build(:material)
      expect(material).to be_valid
    end
    it "nameが空では登録できないこと" do
      material = build(:material, name: "")
      material.valid?
      expect(material.errors[:name]).to include("を入力してください")
    end
    it "postcodeが空では登録できないこと" do
      material = build(:material, postcode: "")
      material.valid?
      expect(material.errors[:postcode]).to include("を入力してください")
    end
    it "prefecture_codeが空では登録できないこと" do
      material = build(:material, prefecture_code: "")
      material.valid?
      expect(material.errors[:prefecture_code]).to include("を入力してください")
    end
    it "address_cityが空では登録できないこと" do
      material = build(:material, address_city: "")
      material.valid?
      expect(material.errors[:address_city]).to include("を入力してください")
    end
    it "address_buildingが空でも登録できること" do
      material = build(:material, address_building: "")
      expect(material).to be_valid
    end
    it "explanationが空では登録できないこと" do
      material = build(:material, explanation: "")
      material.valid?
      expect(material.errors[:explanation]).to include("を入力してください")
    end
  end
  describe '#search' do
    it "nameが検索できること" do
      material = create(:material)
      another_material = create(:material, name: "にんじん")
      expect(Material.search("卵")).to include(material)
      expect(Material.search("にんじん")).to include(another_material)
    end
    it "一致するデータがないとき、空の値を返す" do
      expect(Material.search("卵")).to be_empty
    end
  end
end
