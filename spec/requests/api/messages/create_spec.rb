# frozen_string_literal: true

require 'rails_helper'

describe '/messages', type: :request do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:header) { http_basic_auth_header(user) }

  describe 'success' do
    it 'POST / creates a new message' do
      params = { message: { content: 'Uma mensagem', receiver_id: second_user.id } }
      post '/api/v1/messages.json', params: params, headers: header

      parsed_response = response.parsed_body

      expect(response).to have_http_status(:created)
      expect(parsed_response['data']['conteudo']).to eq('Uma mensagem')
      expect(parsed_response['data']['remetente_id']).to eq(user.id)
      expect(parsed_response['data']['destinatario_id']).to eq(second_user.id)
    end
  end

  describe 'failure' do
    it 'POST /messages fail to create a message' do
      params = { message: { content: '', receiver_id: second_user.id } }

      post '/api/v1/messages.json', params: params, headers: header

      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = response.parsed_body

      expect(parsed_response['errors']).to include("Content can't be blank")
    end
  end
end
