<template>
  <b-list-group-item class="list-container">
    <p>{{ product.name }}</p>
  </b-list-group-item>
</template>


<script>
  export default {
    name: 'ProductItem',
    props: ['product'],
  };
</script>

<style scoped>

</style>
