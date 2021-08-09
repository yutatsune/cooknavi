require 'rails_helper'

RSpec.describe RecipeLike, type: :model do
  before do
    @like = build(:recipe_like)
  end
  describe '正常値と異常値の確認' do
    context 'recipe_likeモデルのバリデーション' do
      it "user_idとrecipe_idがあれば保存できる" do
        expect(create(:recipe_like)).to be_valid
      end
    end
  end
end
