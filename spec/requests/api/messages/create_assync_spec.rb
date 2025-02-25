# frozen_string_literal: true

require 'rails_helper'

describe '/messages', type: :request do
  let(:user) { User.create!(email: 'x@x.com', password: '123456') }
  let(:second_user) { create(:user) }

  before(:each) { sign_in(user) }

  describe 'success' do
    it 'POST /create_assync enfileira uma mensagem no Sidekiq' do
      params = { message: { content: 'Uma mensagem assíncrona', receiver_id: second_user.id } }

      post '/api/v1/messages/create_assync', params: params

      expect(response).to have_http_status(:accepted)
      parsed_response = response.parsed_body

      expect(parsed_response['message']).to eq('Mensagem Adicionada a Fila')
    end
  end

  describe 'failure' do
    it 'POST /create_assync falha ao enfileirar mensagem sem conteúdo' do
      params = { message: { content: '', receiver_id: second_user.id } }

      post '/api/v1/messages/create_assync', params: params

      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = response.parsed_body

      expect(parsed_response['errors']).to include("Content can't be blank")
    end
  end
end
