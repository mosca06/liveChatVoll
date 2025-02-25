class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(user_id, message_params)
    user = User.find_by(id: user_id)
    unless user
      Rails.logger.info "Erro ao criar mensagem: Usuário não encontrado."
      return
    end
    message = user.sent_messages.new(message_params)

    if message.save
      Rails.logger.info "Mensagem criada com sucesso!"
    else
      Rails.logger.info "Erro ao criar mensagem: #{message.errors.full_messages.join(', ')}"
    end
  end
end
