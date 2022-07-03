module Api
  module V1
    class NewsSourcesController < ApplicationController
      def index
        @news_sources = NewsSource.all

        render json: { result: @news_sources }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def show
        @news_source = NewsSource.find_by_id(news_sources_id)
        raise_news_source_not_found(id: news_sources_id) unless @news_source.present?

        render json: { result: @news_source }
      rescue NewsSourceNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def create
        @news_source = NewsSource.new(news_sources_params)
        if @news_source.save
          render json: { result: @news_source }
        else
          render json: { error: "Não foi possível criar uma nova fonte de notícias." }, status: :bad_request
        end
      end

      def update
        @news_source = NewsSource.find_by_id(news_sources_id)
        raise_agenda_not_found(id: news_sources_id) unless @news_source.present?

        if @news_source.update(news_sources_params)
          render json: { result: @news_source }
        else
          render json: { error: "Não foi possível editar essa fonte de notícias." }, status: :bad_request
        end
      rescue NewsSourceNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      def destroy
        @news_source = NewsSource.find_by_id(news_sources_id)
        raise_news_source_not_found(id: news_sources_id) unless @news_source.present?

        if @news_source.destroy
          render json: { result: "A fonte de notícia foi deletada com sucesso!" }
        else
          render json: { error: "Não foi possível deletar a fonte de notícia." }, status: :bad_request
        end
      rescue NewsSourceNotFoundException => e
        render json: { error: e.message }, status: :not_found
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end

      private

      def news_sources_id
        params[:id]
      end

      def news_sources_params
        params.permit(:name, :url, :credibility)
      end

      def raise_news_source_not_found(id:)
        raise NewsSourceNotFoundException.new(id: id)
      end

    end
  end
end