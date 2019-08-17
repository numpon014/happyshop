<template>
  <div id="top-banner">
    <b-jumbotron bg-variant="info" text-variant="white">
      <template slot="header">Happy Shoping</template>
      <template slot="lead">
        Welcome to our shop
      </template>
    </b-jumbotron>
  </div>
</template>

<script lang="ts">
  import { Vue } from 'vue-property-decorator';
  export default class Header extends Vue {}
</script>

<style scoped lang="scss">
  /*#top-banner {*/
  /*  background-color: black;*/
  /*  height: 40px;*/
  /*  padding: 10px;*/
  /*  span {*/
  /*    color: aliceblue;*/
  /*  }*/
  /*}*/
</style>
