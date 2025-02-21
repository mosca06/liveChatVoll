<template>
  <div class="messages">
    <h2>Suas Mensagens</h2>
    <ul v-if="messages.length > 0">
      <li v-for="message in messages" :key="message.id">
        {{ message.content }}
      </li>
    </ul>
    <p v-else>Você não tem mensagens.</p>
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
      const response = await fetch("http://127.0.0.1:3000/api/v1/messages.json", {
        method: "GET",
        credentials: "include",
        headers: {
          "Content-Type": "application/json"
        }
      });

      if (!response.ok) {
        throw new Error("Erro ao buscar mensagens");
      }

      this.messages = await response.json(); // Salva as mensagens no estado
    } catch (error) {
      console.error("Erro ao carregar mensagens:", error);
    }
  }
};
</script>

<style scoped>
.messages {
  padding: 20px;
  max-width: 600px;
  margin: auto;
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
  text-align: center;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  background: #f4f4f4;
  margin: 5px 0;
  padding: 10px;
  border-radius: 5px;
}
</style>
