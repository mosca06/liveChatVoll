<template>
  <div class="login-container">
    <form @submit.prevent="login" class="login-form">
      <h2>Login</h2>

      <label for="email">Email:</label>
      <input type="email" v-model="email" id="email" required />

      <label for="password">Senha:</label>
      <input type="password" v-model="password" id="password" required />

      <button type="submit">Entrar</button>

      <div v-if="message" :class="['message', messageType]">
        {{ message }}
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: '',
      message: '',
      messageType: ''
    };
  },
  methods: {
    async login() {
      try {
        const response = await fetch('http://localhost:3000/api/v1/login', {
          method: 'POST',
          credentials: "include",
          headers: {
            'Authorization': 'Basic ' + btoa(`${this.email}:${this.password}`),
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: this.email,
            password: this.password
          })
        });

        const data = await response.json();

        if (response.ok) {
          this.messageType = 'success';
          this.message = 'Login realizado com sucesso!';

          setTimeout(() => {
            this.$router.push('/messages');
          }, 1000);
        } else {
          this.messageType = 'error';
          this.message = data.message || 'Credenciais inválidas. Tente novamente.';
        }
      } catch (error) {
        console.error('Erro de login:', error);
        this.messageType = 'error';
        this.message = 'Erro ao tentar fazer login. Tente novamente.';
      }
    }
  }
};
</script>

<style scoped>
/* Centraliza o formulário */
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f5f5f5;
}

/* Estiliza o formulário */
.login-form {
  max-width: 400px;
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
  width: 100%;
  text-align: center;
}

/* Títulos */
h2 {
  margin-bottom: 1rem;
  color: #333;
}

/* Campos de entrada */
input {
  width: 100%;
  padding: 10px;
  margin: 8px 0;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 1rem;
}

/* Botão */
button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  border: none;
  color: white;
  font-size: 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s ease-in-out;
}

button:hover {
  background-color: #0056b3;
}

/* Mensagens */
.message {
  margin-top: 10px;
  padding: 10px;
  border-radius: 4px;
  font-size: 0.9rem;
}

/* Mensagem de erro */
.error {
  background-color: #ffcccc;
  color: #a00;
  border: 1px solid #a00;
}

/* Mensagem de sucesso */
.success {
  background-color: #ccffcc;
  color: #080;
  border: 1px solid #080;
}
</style>