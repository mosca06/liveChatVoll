import { createRouter, createWebHistory } from 'vue-router';
import LoginView from './views/LoginView.vue';
import MessagesView from './views/MessagesView.vue';

const routes = [
  { path: '/', component: LoginView },
  { path: '/messages', component: MessagesView }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
