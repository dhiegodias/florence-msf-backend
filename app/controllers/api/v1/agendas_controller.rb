module Api
  module V1
    class AgendasController < ApplicationController

      def index
        @agendas = Agenda.all

        render json: { result: @agendas }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

    end
  end
end
