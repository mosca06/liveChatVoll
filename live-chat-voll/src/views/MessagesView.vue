<template>
  <div class="messages-container">
    <h2>Suas Mensagens</h2>

    <button @click="novaMensagem" class="new-message-btn">Nova Mensagem</button>

    <div v-if="messages.length > 0">
      <table class="message-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Tipo</th>
            <th>Remetente</th>
            <th>Destinatário</th>
            <th>Conteúdo</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="message in messages" :key="message.id">
            <td>{{ message.id }}</td>
            <td>{{ message.type }}</td>
            <td>{{ message.remetente_id }}</td>
            <td>{{ message.destinatario_id }}</td>
            <td>{{ message.conteudo }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <p v-else class="no-messages">Você não tem mensagens.</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      messages: [],
    };
  },
  async created() {
    try {
      const response = await fetch("http://localhost:3000/api/v1/messages",
       { headers: { 'Accept': 'application/json',
                    'Content-Type': 'application/json'
                  },
        credentials: 'include',
        method: 'GET'
       });

      if (!response.ok) {
        throw new Error("Erro ao buscar mensagens");
      }

      let data_response = await response.json();
      this.messages = data_response.data;
    } catch (error) {
      console.error("Erro ao carregar mensagens:", error);
    }
  },
  methods: {
    novaMensagem() {
      this.$router.push('/nova-mensagem'); // Navega para a página de nova mensagem
    }
  }
};
</script>

<style scoped>
  .messages-container {
    padding: 20px;
    max-width: 800px;
    margin: auto;
    background: white;
    border-radius: 8px;
    text-align: center;
  }

  h2 {
    margin-bottom: 20px;
    color: #333;
  }

  .new-message-btn {
    background-color: #28a745;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-bottom: 15px;
  }

  .new-message-btn:hover {
    background-color: #218838;
  }

  .message-table {
    width: 100%;
    border-collapse: collapse;
  }

  .message-table th, .message-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
  }

  .message-table th {
    background: #f4f4f4;
    font-weight: bold;
  }

  .no-messages {
    margin-top: 20px;
    font-size: 1.2rem;
    color: #666;
  }
</style>
