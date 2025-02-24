<template>
  <div class="new-message-container">
    <h2>Criar Nova Mensagem</h2>

    <form @submit.prevent="enviarMensagem">
      <div class="form-group">
        <label for="receiver_id">ID do Destinatário:</label>
        <input type="number" v-model="receiver_id" id="receiver_id" required />
      </div>

      <div class="form-group">
        <label for="content">Conteúdo:</label>
        <textarea v-model="content" id="content" required></textarea>
      </div>

      <button type="submit" class="send-btn">Enviar</button>
      <button type="button" @click="voltar" class="back-btn">Voltar</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      receiver_id: '',
      content: ''
    };
  },
  methods: {
    async enviarMensagem() {
      try {
        const response = await fetch("http://localhost:3000/api/v1/messages", {
          method: "POST",
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify({
            message: {
              receiver_id: this.receiver_id,
              content: this.content
            }
            
          })
        });

        if (!response.ok) {
          throw new Error("Erro ao enviar a mensagem.");
        }

        alert("Mensagem enviada com sucesso!");
        this.$router.push('/messages'); 
      } catch (error) {
        console.error("Erro ao enviar mensagem:", error);
        alert("Erro ao enviar mensagem.");
      }
    },
    voltar() {
      this.$router.push('/messages'); 
    }
  }
};
</script>

<style scoped>
  .new-message-container {
    padding: 20px;
    max-width: 500px;
    margin: auto;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
  }

  h2 {
    margin-bottom: 20px;
    color: #333;
  }

  .form-group {
    margin-bottom: 15px;
    text-align: left;
  }

  label {
    display: block;
    font-weight: bold;
  }

  input, textarea {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }

  textarea {
    height: 100px;
  }

  .send-btn, .back-btn {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
  }

  .back-btn {
    background-color: #6c757d;
  }

  .send-btn:hover {
    background-color: #0056b3;
  }

  .back-btn:hover {
    background-color: #5a6268;
  }
</style>
