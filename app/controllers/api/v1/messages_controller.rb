module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      before_action :authenticate_user!

      def create
        @message = current_user.sent_messages.new(message_params)
        if @message.save
          render :create, status: :created
        else
          render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        @messages = Message.where('sender_id = :user_id OR receiver_id = :user_id', user_id: current_user.id)
      end

      private

      def message_params
        params.require(:message).permit(:content, :receiver_id)
      end
    end
  end
end
