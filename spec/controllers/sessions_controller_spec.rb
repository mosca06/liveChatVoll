require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  include Authentication

  let(:user) do
    User.create!(email: 'x@example.com', password: '123456', session: 'abc123', session_expires_at: 1.hour.ago)
  end

  before do
    sign_in(user)
  end

  describe 'POST #create' do
    it 'renova a sessão do usuário se estiver vazia e retorna mensagem de sucesso' do
      allow_any_instance_of(User).to receive(:renew_session!).and_call_original

      post :create

      user.reload
      expect(user.session).not_to be_nil
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['message']).to eq('Logado com sucesso')
    end
  end

  describe 'DELETE #destroy' do
    it 'remove a sessão do usuário e retorna mensagem de sucesso' do
      delete :destroy

      user.reload

      expect(user.session).to be_nil
      expect(user.session_expires_at).to be_nil
      expect(session[:session]).to be_nil
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['message']).to eq('Desconectado')
    end
  end

  describe 'Session expiration' do
    it 'remove a sessão do usuário se estiver expirada' do
      user.update!(session_expires_at: 1.hour.ago)

      get :create

      user.reload
      expect(user.session).to be_nil
      expect(user.session_expires_at).to be_nil
    end
  end
end
