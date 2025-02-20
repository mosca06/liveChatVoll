module Api
  module V1
    class SessionsController < Api::V1::ApplicationController
      before_action :authorize_user!

      def create
        @user.renew_session! if @user.session.nil?
        session[:session] = @user.session
        render json: { message: 'Logado com sucesso' }
      end

      def destroy
        @user.update!(session: nil, session_expires_at: nil)
        @user = nil
        session[:session] = nil
        render json: { message: 'Desconectado' }
      end
    end
  end
end
