json.data @messages do |message|
  json.id                 message.id
  json.destinatario_id    message.receiver_id
  json.remetente_id       message.sender_id
  json.conteudo           message.content
end
