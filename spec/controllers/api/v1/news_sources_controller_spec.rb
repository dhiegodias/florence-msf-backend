require 'rails_helper'

describe Api::V1::NewsSourcesController do
  let!(:news_source1) { FactoryBot.create(:news_source) }
  let!(:news_source2) { FactoryBot.create(:news_source) }

  describe "#index" do
    context "when request is successful" do
      let!(:response) { get :index }
      let!(:news_sources) { JSON.parse(response.body)["result"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct number of news_source" do
        expect(news_sources.count).to eq(2)
      end
    end

    context "when an error occurs" do
      before do
        allow(NewsSource).to receive(:all).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :index

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#show" do
    let(:id) { news_source1.id }
    let(:params) { { id: id } }

    context "when request is successful" do
      let!(:response) { get :show, params: params }
      let!(:news_source) { JSON.parse(response.body)["result"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct agenda" do
        expect(news_source["id"]).to eq(id)
      end
    end

    context "when news source is not found" do
      let!(:response) { get :show, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi encontrado a fonte de notícias com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when an error occurs " do
      before do
        allow(NewsSource).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :show, params: params

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#create" do
    context "when params are correct" do
      let(:params) { { name: "G1", url: "www.g1.com.br", credibility: "Confiável"} }

      it "creates agenda" do
        expect{
          post :create, params: params
        }.to change(NewsSource,:count).by(1)
      end
    end

    context "when params are incomplete" do
      let(:params) { { name: "", url: "www.g1.com.br",  credibility:""} }

      it "does not creates agenda" do
        expect{
          post :create, params: params
        }.to change(NewsSource,:count).by(0)
      end
    end
  end

  describe "#update" do
    let(:id) { news_source1.id }
    let(:params) { { id: id, name: "Novo título" } }

    context "when agenda is not found" do
      let!(:response) { put :update, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Ocorreu um erro inesperado" }

      it "returns code 400" do
        expect(response.status).to eq(400)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when update is successful" do
      let!(:response) { put :update, params: params }
      let(:body) { JSON.parse(response.body) }

      it "returns updated news source" do
        expect(body["result"]["name"]).to eq("Novo título")
      end
    end

    context "when an error occurs" do
      before do
        allow(NewsSource).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        put :update, params: params

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#destroy" do
    let(:id) { news_source1.id }
    let(:params) { { id: id } }

    context "when news source is not found" do
      let!(:response) { delete :destroy, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi encontrado a fonte de notícias com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when destroy is successful" do
      it "deletes agenda" do
        expect{
          delete :destroy, params: params
        }.to change(NewsSource,:count).by(-1)
      end
    end

    context "when an error occurs" do
      before do
        allow(NewsSource).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        delete :destroy, params: params

        expect(response.status).to eq(400)
      end

      it "does not delete object" do
        expect{
          delete :destroy, params: params
        }.to change(NewsSource,:count).by(0)
      end
    end
  end
end