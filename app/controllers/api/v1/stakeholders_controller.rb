module Api
  module V1
    class StakeholdersController < ApplicationController

      def index
        @stakeholders = Stakeholder.all

        render json: { result: @stakeholders }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado." }, status: :bad_request
      end

      def show
        set_stakeholder
        raise_stakeholder_not_found(id: stakeholder_params[:id]) unless @stakeholder.present?

        render json: { result: @stakeholder }
      rescue StakeholderNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado." }, status: :bad_request
      end

      def create
        @stakeholder = Stakeholder.new(stakeholder_params)

        if @stakeholder.save
          render json: { result: @stakeholder }, status: :created
        else
          render json: { error: "Não foi possível criar um novo Stakeholder." }, status: :bad_request
        end
      end

      def update
        set_stakeholder
        raise_stakeholder_not_found(id: stakeholder_params[:id]) unless @stakeholder.present?

        if @stakeholder.update(stakeholder_params)
          render json: { result: @stakeholder }, status: :ok
        else
          render json: { error: "Não foi possível atualizar o Stakeholder." }, status: :bad_request
        end
      rescue StakeholderNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado." }, status: :bad_request
      end

      def destroy
        set_stakeholder
        raise_stakeholder_not_found(id: stakeholder_params[:id]) unless @stakeholder.present?

        if @stakeholder.destroy
          render json: { result: "Stakeholder deletado com sucesso." }, status: :ok
        else
          render json: { error: "Não foi possível deletar o Stakeholder." }, status: :bad_request
        end
      rescue StakeholderNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado." }, status: :bad_request
      end

      private

      def set_stakeholder
        @stakeholder = Stakeholder.find_by_id(params[:id])
      end

      def stakeholder_params
        params.permit(:id, :name, :position, :twitter, :instagram, :role, :phone, :email, :organization)
      end

      def raise_stakeholder_not_found(id:)
        raise StakeholderNotFoundException.new(id: id)
      end
    end
  end
end