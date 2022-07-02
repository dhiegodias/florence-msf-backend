require 'rails_helper'

describe Api::V1::StakeholdersController do
  let!(:stakeholder1) { FactoryBot.create(:stakeholder) }
  let!(:stakeholder2) { FactoryBot.create(:stakeholder) }

  describe "#index" do
    context "when request is successful" do
      let!(:response) { get :index }
      let!(:stakeholders) { JSON.parse(response.body)["result"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct number of stakeholders" do
        expect(stakeholders.count).to eq(2)
      end

      it "returns the necessary keys" do
        expect(stakeholders.first.keys).to include("name")
      end
    end

    context "when an error occurs" do
      before do
        allow(Stakeholder).to receive(:all).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :index

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#show" do
    let(:id) { stakeholder1.id }
    let(:params) { { id: id } }

    context "when request is successful" do
      let!(:response) { get :show, params: params }
      let!(:stakeholder) { JSON.parse(response.body)["result"] }

      it "returns code 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct stakeholder" do
        expect(stakeholder["id"]).to eq(id)
      end

      it "returns the necessary keys" do
        expect(stakeholder.keys).to include("name")
      end
    end

    context "when stakeholder is not found" do
      let!(:response) { get :show, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi possível encontrar stakeholder com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when an error occurs " do
      before do
        allow(Stakeholder).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        get :show, params: params

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#create" do
    context "when params are correct" do
      let(:params) { { name: "Teste" } }

      it "creates stakeholder" do
        expect{ post :create, params: params }.to change(Stakeholder, :count).by(1)
      end
    end

    context "when params are incomplete" do
      let(:params) { { name: "" } }

      it "does not creates stakeholder" do
        expect{ post :create, params: params }.to change(Stakeholder, :count).by(0)
      end
    end
  end

  describe "#update" do
    let(:id) { stakeholder1.id }
    let(:params) { { id: id, name: "Teste" } }

    context "when stakeholder is not found" do
      let!(:response) { put :update, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi possível encontrar stakeholder com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when update is successful" do
      let!(:response) { put :update, params: params }
      let(:body) { JSON.parse(response.body) }

      it "returns updated stakeholder" do
        expect(body["result"]["name"]).to eq("Teste")
      end
    end

    context "when an error occurs" do
      before do
        allow(Stakeholder).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        put :update, params: params

        expect(response.status).to eq(400)
      end
    end
  end

  describe "#destroy" do
    let(:id) { stakeholder1.id }
    let(:params) { { id: id } }

    context "when stakeholder is not found" do
      let!(:response) { delete :destroy, params: { id: 1 } }
      let(:body) { JSON.parse(response.body) }
      let(:message) { "Não foi possível encontrar stakeholder com id 1" }

      it "returns code 404" do
        expect(response.status).to eq(404)
      end

      it "returns the correct message" do
        expect(body["error"]).to eq(message)
      end
    end

    context "when destroy is successful" do
      it "deletes stakeholder" do
        expect{ delete :destroy, params: params }.to change(Stakeholder, :count).by(-1)
      end
    end

    context "when an error occurs" do
      before do
        allow(Stakeholder).to receive(:find_by_id).and_raise(RuntimeError)
      end

      it "returns code 400" do
        delete :destroy, params: params

        expect(response.status).to eq(400)
      end

      it "does not delete object" do
        expect{ delete :destroy, params: params }.to change(Stakeholder, :count).by(0)
      end
    end
  end
end