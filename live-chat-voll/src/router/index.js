import Vue from 'vue';
import Router from 'vue-router';
import LoginPage from './components/LoginPage.vue';
import UserDashboard from './components/UserDashboard.vue';

// Registrar o Vue Router como um plugin
Vue.use(Router);

const routes = [
  { path: '/', component: LoginPage },
  { path: '/dashboard', component: UserDashboard }
];

const router = new Router({
  routes
});

export default router;
