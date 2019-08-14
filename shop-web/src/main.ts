import Vue from 'vue';
import App from './App.vue';
import router from './router';
import BootstrapVue from 'bootstrap-vue';
import './registerServiceWorker';
import ApiService from './services/Service';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import VueSlider from 'vue-slider-component';

Vue.config.productionTip = false;
Vue.use(BootstrapVue);

Vue.component('font-awesome-icon', FontAwesomeIcon);
Vue.component('VueSlider', VueSlider);

const parts = location.hostname.split('.');
const subdomain = parts.shift();
const baseURL = subdomain === 'localhost' ? 'http://localhost:3000' : `https://${subdomain}.numpon.com/api`;

ApiService.init(baseURL);

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
