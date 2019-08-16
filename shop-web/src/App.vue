<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<style lang="scss">
#app {
  font-size: 0.9em;
}
</style>

<script>
    import Header from '@/components/Header.vue';
    import 'bootstrap/dist/css/bootstrap.css';
    import 'bootstrap-vue/dist/bootstrap-vue.css';
    import 'vue-slider-component/theme/default.css';

    export default {
      name: 'App',
      components: {
        Header,
      },
    };
</script>
