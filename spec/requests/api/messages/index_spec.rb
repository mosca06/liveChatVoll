# frozen_string_literal: true

require 'rails_helper'

describe '/messages', type: :request do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let!(:first_message) { create(:message, sender: user, receiver: second_user, content: 'Primeira mensagem') }
  let!(:second_message) { create(:message, sender: second_user, receiver: user, content: 'Segunda mensagem') }

  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'success' do
    it 'GET /messages returns all messages for the current user' do
      get '/api/v1/messages', params: { format: :json }
      expect(response).to have_http_status(:ok)

      parsed_response = response.parsed_body

      expect(parsed_response['data'].size).to eq(2)
      expect(parsed_response['data'].first['conteudo']).to eq('Primeira mensagem')
      expect(parsed_response['data'].second['conteudo']).to eq('Segunda mensagem')
    end
  end
end
