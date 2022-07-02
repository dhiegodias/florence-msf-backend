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

      private

      def agenda_id
        params[:id]
      end

      def raise_agenda_not_found(id:)
        raise AgendaNotFoundException.new(id: id)
      end

    end
  end
end
