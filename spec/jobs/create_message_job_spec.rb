RSpec.describe CreateMessageJob, type: :job do
  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let(:valid_message_params) { { 'content' => 'Hello, world!', 'receiver_id' => receiver.id } }
  let(:invalid_message_params) { { 'content' => nil, 'receiver_id' => receiver.id } }

  before do
    Sidekiq::Testing.inline! # Garante que os jobs são executados imediatamente
  end

  it 'cria uma mensagem com sucesso' do
    expect_any_instance_of(Logger).to receive(:info).with('Mensagem criada com sucesso!')
    CreateMessageJob.new.perform(sender.id, valid_message_params)
  end

  it 'não cria mensagem se o usuário não existir' do
    expect(Rails.logger).to receive(:info).with('Erro ao criar mensagem: Usuário não encontrado.')
    CreateMessageJob.new.perform(9999, { content: 'Teste' }) # ID inexistente
  end

  it 'não cria mensagem se houver erro de validação' do
    expect_any_instance_of(Logger).to receive(:info).with(/Erro ao criar mensagem:/)
    CreateMessageJob.new.perform(sender.id, invalid_message_params) # Mensagem sem conteúdo
  end
end
