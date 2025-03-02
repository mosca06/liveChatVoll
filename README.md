# LiveChatVoll

## 🚀 Sobre o Projeto
LiveChatVoll é um sistema de chat , permitindo o envio de mensagens e arquivos entre usuários.<br>
Quadro de Tarefas: https://github.com/users/mosca06/projects/10

## 📌 Tecnologias Utilizadas

### **Backend:**
- Ruby on Rails
- PostgreSQL
- Sidekiq (para processamento assíncrono de mensagens)
- Redis (para fila de processamento)
- Devise (para autenticação de usuários)
- RSpec (para testes automatizados)
- Rubocop (boas praticas)
- SimpleCov (cobertura de testes)
- Kaminari (paginação)

### **Frontend:**
- Vue.js
- Axios 

---

## 📖 Passo a Passo para Configurar e Executar o Projeto

### **1️⃣ Clonando o Repositório**
```sh
 git clone https://github.com/mosca06/liveChatVoll.git
 cd liveChatVoll
```

### **2️⃣ Configurando o Backend (Rails)**

#### **Instalar dependências**
```sh
bundle install
```

#### **Configurar o banco de dados**
```sh
rails db:create db:migrate db:seed
```

#### **Subir o servidor Rails**
```sh
rails s
```

#### **Rodando os testes**
```sh
rspec
```

#### **Rodando o RuboCop**
Para verificar se o código segue as boas práticas do Ruby, utilize o RuboCop:

```sh
rubocop
```

#### **Rodando o Redis**
```sh
redis-server
```

#### **Rodando o Sidekiq** (necessário para mensagens assíncronas)
```sh
sidekiq
```

---

### **3️⃣ Configurando o Frontend**

#### **Instalar dependências**
```sh
cd live-chat-voll
npm install
```

#### **Rodar o servidor frontend**
```sh
npm run dev
```

### **4️⃣ API Entry Points**

Autenticação
<details>
  <summary>🔹 Login :</summary>

  Método: POST 
  ```
  127.0.0.1:3000/api/v1/auth/login
  ```
  
  AUTH:
  ```
  username:"x@example.com"
  password:"123456"
  ```
  
  RESPONSE:
  ```
  {
    "message": "Logado com sucesso"
  }
  ```

  <summary>🔹 Logout :</summary>

  Método: DELETE 
  ```
  127.0.0.1:3000/api/v1/logout
  ```
  
  RESPONSE:
  ```
 {
	"message": "Desconectado"
  }
  ```
</details>
<hr>
Criar Mensagens
<details> <summary>🔹 Create</summary>

🔹 Com Arquivo :
  <details>
  Método: POST 

  ```
  127.0.0.1:3000/api/v1/messages
  ```
    
  Exemplo no Insomnia/Postman
  Adicione os seguintes campos:
  ```
  message[content] → "Olá, isso é um teste!"
  message[receiver_id] → 2
  message[file] → Selecione o arquivo no seu computador
  ```
  
  RESPONSE:
  ```
  {
    "data": {
      "type": "messagem",
      "id": 55,
      "destinatario_id": 2,
      "remetente_id": 1,
      "conteudo": "Olá, isso é um teste!",
      "file_url": "/rails/active_storage/blobs/redirect/....."
    }
  }
  ```
  </details>
🔹 Sem Arquivo :
 <details>
Método: POST 
   
```
  127.0.0.1:3000/api/v1/messages
```
  

  Body:
  ```
 {
  "message": {
    "content": "Olá, isso é um teste!",
    "receiver_id": 2
  }
}
  ```
  
  RESPONSE:
  ```
  {
	"data": {
		"type": "messagem",
		"id": X,
		"destinatario_id": 2,
		"remetente_id": X,
		"conteudo": "Olá, isso é um teste!"
	}
}
  ```
  </details>

  🔹 Mensagem assincrona:
  <details>
    Método: POST 
   
  ```
    127.0.0.1:3000/api/v1/messages/create_assync
  ```
  Body:
  ```
 {
  "message": {
    "content": "Olá, isso é um teste!",
    "receiver_id": 2
  }
}
  ```

RESPONSE:
  ```
  {
	"message": "Mensagem Adicionada a Fila"
}
  ```


  </details>
</details>
<hr>
Visualizar 
<details>
  <summary>🔹 Visualizar Mensagens :</summary>

  Método: GET  
  ```
  http://127.0.0.1:3000/api/v1/messages?page=1&per_page=5
  ```
   Os atributos devem ser escolhidos pelo usuario:<br>
     page: pagina desejada <br>
     per_page: quantas mensagens por pagina 
  
  RESPONSE:
  ```
 {
	"data": [
		{
			"type": "mensagem",
			"id": 55,
			"destinatario_id": 2,
			"remetente_id": 1,
			"conteudo": "Olá, isso é um teste!",
			"file_url": "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MiwicHVyIjoiYmxvYl9pZCJ9fQ==--0206fb14a48f1a8ba00c478250ff5fcc3a5b27cb/images%20(5).jpeg"
		},
    ...
  }
  ```
  
</details>
<hr>
Metricas 
<details>
  <summary>🔹 Visualizar Metricas :</summary>

  Método: GET  
  ```
  127.0.0.1:3000/api/v1/messages/metrics
  ```
  RESPONSE:
  ```
 {
	"total_messages": 53,
	"active_users": 3
}
  ```

</details>


## 5️⃣ Diferenciais Implementados
-  **Suporte a envio de arquivos** .
- 🟢**Mensagens assíncronas com Sidekiq** .
- 📊 **Endpoint `/metrics`** para exibir estatísticas de mensagens enviadas e usuários ativos.
- 🔐 **Autenticação segura **.
- ✅ **Testes automatizados com RSpec**.
- 📊 **Implementação de paginação na listagem de mensagens**.




