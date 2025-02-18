# spec/models/message_spec.rb

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    message = Message.new(content: 'Hello', sender: user, receiver: user)
    expect(message).to be_valid
  end

  it 'is not valid without content' do
    user = User.create!(email: 'test@example.com', password: 'password')
    message = Message.new(sender: user, receiver: user)
    expect(message).not_to be_valid
  end
end
