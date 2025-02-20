module Api
  module V1
    class ApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Basic::ControllerMethods

      private

      def authorize_user!
        render json: {}, status: :unauthorized unless basic_authenticate!
      end

      def basic_authenticate!
        authenticate_with_http_basic do |email, password|
          fetch_user(email)
          @current_user&.valid_password?(password)
        end
      end

      def fetch_user(email)
        @current_user = User.find_by(email: email)
      end
    end
  end
end
