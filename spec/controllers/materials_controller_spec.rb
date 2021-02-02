require 'rails_helper'

describe MaterialsController do
  describe "#index" do
    it "created_at DESCで並べ替えられたツイートの配列を入力できるか" do
      materials = create_list(:material, 3)
      get :index
      expect(assigns(:materials)).to match(materials.sort{|a, b| b.created_at <=> a.created_at })
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
        expect(response).to redirect_to(materials_path)
      end
    end
  end
  describe 'GET #edit' do
    it "リクエストされたmaterialを@materialに割り当てられるか" do
      material = create(:material)
      get :edit, params: { id: material }
      expect(assigns(:material)).to eq material
    end
    context "login user" do
      before do
        user = create(:user)
        login user
      end
      it "editテンプレートをレンダリングできるか" do
        material = create(:material)
        get :edit, params: { id: material }
        expect(response).to render_template :edit
      end
    end
    context "no login user" do
      it "indexにリダイレクトするかどうか" do
        user = create(:user)
        login user
        material = create(:material)
        logout user
        get :edit, params: { id: material }
        expect(response).to redirect_to(materials_path)
      end
    end
  end
end