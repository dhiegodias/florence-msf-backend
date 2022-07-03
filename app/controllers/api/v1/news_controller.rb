module Api
  module V1
    class NewsController < ApplicationController

      def index
        agenda = Agenda.find_by_id(params[:agenda_id])
        keywords = agenda.keywords

        api = NewsApi.build
        @news = api.get_by_keywords(keywords: keywords)

        render json: { result: @news }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end
    end
  end
end
