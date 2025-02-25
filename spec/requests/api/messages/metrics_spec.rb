# frozen_string_literal: true

require 'rails_helper'

describe '/metrics', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:message1) { create(:message, sender: user1, receiver: user2) }
  let!(:message2) { create(:message, sender: user2, receiver: user1) }
  before(:each) { sign_in(user1) }

  it 'GET /metrics retorna estatísticas' do
    get '/api/v1/messages/metrics'

    expect(response).to have_http_status(:ok)
    parsed_response = response.parsed_body

    expect(parsed_response['total_messages']).to eq(2)
    expect(parsed_response['active_users']).to eq(2)
  end
end
