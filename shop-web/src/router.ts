import Vue from 'vue';
import Router from 'vue-router';
import ProductPage from '@/views/ProductPage.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/product',
      name: 'ProductPage.vue',
      component: ProductPage,
    },
    {
      path: '*',
      component: ProductPage,
    },
  ],
});
