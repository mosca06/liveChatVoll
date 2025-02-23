import axios from 'axios';

export default {
  data() {
    return {
      email: '',  // Defina o estado para o email
      password: '' // Defina o estado para a senha
    };
  },
  methods: {
    async login() {
      try {
        const email = this.email;
        const password = this.password;

   
        const auth = 'Basic ' + btoa(`${email}:${password}`);

        const response = await axios.post(
          'http://localhost:3000/api/v1/login.json',
          {},
          {
            headers: {
              'Authorization': auth  
            },
            withCredentials: true,  
          }
        );

        console.log('Login bem-sucedido:', response.data);
      } catch (error) {
        console.error('Erro de login:', error.response ? error.response.data : error.message);
        alert('Credenciais inválidas. Tente novamente.');
      }
    }
  }
};
