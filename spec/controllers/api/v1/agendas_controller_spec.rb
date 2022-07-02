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

end
