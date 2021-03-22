require 'rails_helper'

describe RecipesController do
  describe "#index" do
    it "created_at DESCで並べ替えられたツイートの配列を入力できるか" do
      recipes = create_list(:recipe, 3)
      get :index
      expect(assigns(:recipes)).to match(recipes.sort { |a, b| b.created_at <=> a.created_at })
    end
    it "indexテンプレートをレンダリングできるか" do
      get :index
      expect(response).to render_template :index
    end
    it "200レスポンスが返ってきているか" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
  describe 'GET #new' do
    context "login user" do
      before do
        user = create(:user)
        login user
      end
      it "newテンプレートをレンダリングできるか" do
        get :new
        expect(response).to render_template :new
      end
    end
    context "no login user" do
      it "indexにリダイレクトするかどうか" do
        get :new
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
  describe 'GET #edit' do
    it "リクエストされたrecipeを@recipeに割り当てられるか" do
      recipe = create(:recipe)
      get :edit, params: { id: recipe }
      expect(assigns(:recipe)).to eq recipe
    end
    context "login user" do
      before do
        user = create(:user)
        login user
      end
      it "editテンプレートをレンダリングできるか" do
        recipe = create(:recipe)
        get :edit, params: { id: recipe }
        expect(response).to render_template :edit
      end
    end
    context "no login user" do
      it "indexにリダイレクトするかどうか" do
        user = create(:user)
        login user
        recipe = create(:recipe)
        logout user
        get :edit, params: { id: recipe }
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
end
