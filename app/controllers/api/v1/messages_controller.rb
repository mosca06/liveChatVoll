module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      before_action :authorize_user!

      def create
        @message = fetch_user_by_session.sent_messages.new(message_params)
        if @message.save
          render :create, status: :created
        else
          render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        @messages = Message
                    .where('sender_id = :user_id OR receiver_id = :user_id', user_id: fetch_user_by_session.id)
                    .order(created_at: :desc)
                    .page(params[:page])
                    .per(params[:per_page] || 10)
      end

      def create_assync
        fetch_user_by_session
        message = @user.sent_messages.new(message_params)

        if message.valid?
          CreateMessageJob.perform_later(@user.id, message_params.to_h.stringify_keys)
          render json: { message: 'Mensagem Adicionada a Fila' }, status: :accepted
        else
          render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def metrics
        @total_messages = Message.count
        @active_users = User.joins(:sent_messages).distinct.count
        render :metrics, status: :ok
      end

      private

      def message_params
        params.require(:message).permit(:content, :receiver_id)
      end
    end
  end
end
