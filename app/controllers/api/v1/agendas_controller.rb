module Api
  module V1
    class AgendasController < ApplicationController

      def index
        @agendas = Agenda.all

        render json: { result: @agendas }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def show
        @agenda = Agenda.find_by_id(agenda_id)
        raise_agenda_not_found(id: agenda_id) unless @agenda.present?

        render json: { result: @agenda }
      rescue AgendaNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def create
        @agenda = Agenda.new(agenda_params)
        if @agenda.save
          render json: { result: @agenda }
        else
          render json: { error: "Não foi possível criar uma nova agenda." }, status: :bad_request
        end
      end

      def update
        @agenda = Agenda.find_by_id(agenda_id)
        raise_agenda_not_found(id: agenda_id) unless @agenda.present?

        if @agenda.update(agenda_params)
          render json: { result: @agenda }
        else
          render json: { error: "Não foi possível editar essa agenda." }, status: :bad_request
        end
      rescue AgendaNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def destroy
        @agenda = Agenda.find_by_id(agenda_id)
        raise_agenda_not_found(id: agenda_id) unless @agenda.present?

        if @agenda.destroy
          render json: { result: "A agenda foi deletada com sucesso!" }
        else
          render json: { error: "Não foi possível deletar a agenda." }, status: :bad_request
        end
      rescue AgendaNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      private

      def agenda_id
        params[:id]
      end

      def agenda_params
        params.permit(:title, :keywords)
      end

      def raise_agenda_not_found(id:)
        raise AgendaNotFoundException.new(id: id)
      end

    end
  end
end
