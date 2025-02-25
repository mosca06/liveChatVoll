json.data @messages do |message|
  json.type               'mensagem'
  json.id                 message.id
  json.destinatario_id    message.receiver_id
  json.remetente_id       message.sender_id
  json.conteudo           message.content
  json.file_url           url_for(message.file) if message.file.attached?
end

json.pagination do
  json.current_page  @messages.current_page
  json.total_pages   @messages.total_pages
  json.total_count   @messages.total_count
end
