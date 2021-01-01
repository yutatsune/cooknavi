require 'rails_helper'
describe Material do
  describe '#create' do
    it "nameとpostcode、prefecture_code、address_city、address_building、explanation、latitude、longitudeを入れて登録できること" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      expect(material).to be_valid
    end
    it "nameが空では登録できないこと" do
      user = build(:user)
      material = user.materials.build(
        name: "",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      material.valid?
      expect(material.errors[:name]).to include("を入力してください")
    end
    it "postcodeが空では登録できないこと" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      material.valid?
      expect(material.errors[:postcode]).to include("を入力してください")
    end
    it "prefecture_codeが空では登録できないこと" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      material.valid?
      expect(material.errors[:prefecture_code]).to include("を入力してください")
    end
    it "address_cityが空では登録できないこと" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      material.valid?
      expect(material.errors[:address_city]).to include("を入力してください")
    end
    it "address_buildingが空でも登録できること" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "",
        explanation: "卵です！",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      expect(material).to be_valid
    end
    it "explanationが空では登録できないこと" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "",
        latitude: "35.9062",
        longitude: "139.626",
        user_id: "1"
      )
      material.valid?
      expect(material.errors[:explanation]).to include("を入力してください")
    end
    it "latitudeとlongitudeは自動で取得されること" do
      user = build(:user)
      material = user.materials.build(
        name: "卵",
        postcode: "3308511",
        prefecture_code: "11",
        address_city: "さいたま市大宮区大門町１丁目３２",
        address_building: "株式会社　高島屋　大宮店",
        explanation: "卵です！",
        latitude: "",
        longitude: "",
        user_id: "1"
      )
      expect(material).to be_valid
    end
  end
end
