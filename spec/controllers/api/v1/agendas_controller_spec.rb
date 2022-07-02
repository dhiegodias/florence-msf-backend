require 'rails_helper'

describe Api::V1::AgendasController do
  let!(:agenda1) { FactoryBot.create(:agenda) }
  let!(:agenda2) { FactoryBot.create(:agenda) }

  describe "#index" do
    context "when request is successful" do
      let!(:response) { get :index }
      let!(:agendas) { JSON.parse(response.body)["result"] }

      let(:keys) { ["id", "title", "keywords", "created_at", "updated_at"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct number of agendas" do
        expect(agendas.count).to eq(2)
      end

      it "returns the necessary keys" do
        expect(agendas.first.keys).to include("id", "title", "keywords")
      end
    end

    context "when an error occurs" do
      before do
        allow(Agenda).to receive(:all).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :index

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#show" do
    let(:id) { agenda1.id }
    let(:params) { { id: id } }

    context "when request is successful" do
      let!(:response) { get :show, params: params }
      let!(:agenda) { JSON.parse(response.body)["result"] }

      let(:keys) { ["id", "title", "keywords", "created_at", "updated_at"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct agenda" do
        expect(agenda["id"]).to eq(id)
      end

      it "returns the necessary keys" do
        expect(agenda.keys).to include("id", "title", "keywords")
      end
    end

    context "when agenda is not found" do
      let!(:response) { get :show, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi encontrado a agenda com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when an error occurs " do
      before do
        allow(Agenda).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :show, params: params

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#create" do
    context "when params are correct" do
      let(:params) { { title: "Título", keywords: [] } }

      it "creates agenda" do
        expect{
          post :create, params: params
        }.to change(Agenda,:count).by(1)
      end
    end

    context "when params are incomplete" do
      let(:params) { { title: "", keywords: [] } }

      it "does not creates agenda" do
        expect{
          post :create, params: params
        }.to change(Agenda,:count).by(0)
      end
    end
  end

  describe "#destroy" do
    let(:id) { agenda1.id }
    let(:params) { { id: id } }

    context "when agenda is not found" do
      let!(:response) { delete :destroy, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi encontrado a agenda com id 1" }

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
        }.to change(Agenda,:count).by(-1)
      end
    end

    context "when an error occurs" do
      before do
        allow(Agenda).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        delete :destroy, params: params

        expect(response.status).to eq(400)
      end

      it "does not delete object" do
        expect{
          delete :destroy, params: params
        }.to change(Agenda,:count).by(0)
      end
    end
  end

end
