import { createRouter, createWebHistory } from 'vue-router';
import LoginView from './views/LoginView.vue';
import MessagesView from './views/MessagesView.vue';
import NewMessageView from './views/NewMessageView.vue';

const routes = [
  { path: '/', component: LoginView },
  { path: '/messages', component: MessagesView },
  { path: '/nova-mensagem', component: NewMessageView }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
