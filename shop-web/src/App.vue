<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<style lang="scss">
  .page-content {
    margin-top: 10px;
  }
</style>

<script>
    import Header from '@/components/Header.vue';
    import 'bootstrap/dist/css/bootstrap.css';
    import 'bootstrap-vue/dist/bootstrap-vue.css';
    import 'vue-slider-component/theme/default.css';
    import 'vue-multiselect/dist/vue-multiselect.min.css';

    export default {
      name: 'App',
      components: {
        Header,
      },
    };
</script>
