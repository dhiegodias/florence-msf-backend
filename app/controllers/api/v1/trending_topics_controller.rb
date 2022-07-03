module Api
  module V1
    class TrendingTopicsController < ApplicationController

      def index
        response = TwitterApi.trending_tweets
        @trends = response.to_h[:trends]

        render json: { result: @trends }
      rescue => e
        render json: { error: "Ocorreu um erro inesperado"}, status: :bad_request
      end
    end
  end
end
