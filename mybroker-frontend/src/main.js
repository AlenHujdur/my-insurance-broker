import { createApp } from 'vue';
import { createRouter, createWebHashHistory } from 'vue-router';
import '../src/assets/bootstrap/css/bootstrap.min.css';
//import 'bootstrap-vue/dist/bootstrap-vue.css';
//import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap";
import App from './App.vue';
import HomeComponent from './components/Home.vue';
import ContactComponent from './components/Contact.vue';
import BlogComponent from './components/Blog.vue';
import GetQuoteComponent from './components/GetQuoteForm.vue';
//import Navbar from './components/Navbar.vue';

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    { path: '/', component: HomeComponent },
    { path: '/home', component: HomeComponent },
    { path: '/contact', component: ContactComponent },
    { path: '/blog', component: BlogComponent },
    { path: '/get-quote', component: GetQuoteComponent },
    { path: '/sign-up', component: '' },
  ],
  linkActiveClass: "active", // active class for non-exact links.
  linkExactActiveClass: "active" // active class for *exact* links.
});

const app = createApp(App);
app.use(router);
//const navbar = createApp(Navbar);
//navbar.use(router);
//navbar.mount('#navbar');
app.mount('#app');
