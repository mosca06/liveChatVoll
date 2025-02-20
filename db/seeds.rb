# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user_1 = User.create!(
  email: "eduardo@example.com",
  password: "123456",
  password_confirmation: "123456"
)

user_2 = User.create!(
  email: "ana@example.com",
  password: "654321",
  password_confirmation: "654321"
)

user_3 = User.create!(
  email: "x@example.com",
  password: "123456",
  password_confirmation: "123456"
)

Message.create!(
  sender_id:    user_1.id,
  receiver_id:  user_2.id,
  content:    "Primeira mensagem"
)


Message.create!(
  sender_id:    user_2.id,
  receiver_id:  user_3.id,
  content:    "Segunda mensagem"
)


Message.create!(
  sender_id:    user_1.id,
  receiver_id:  user_3.id,
  content:    "Terceira mensagem"
)
