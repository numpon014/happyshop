<template>
  <b-list-group class="product">
    <ProductItem
      v-for="product in this.products"
      v-bind:key="`product-item-${product.id}`"
      :product="product"
    ></ProductItem>
  </b-list-group>
</template>

<script>
  import ProductItem from './ProductItem';
  export default {
    name: 'ProductList',
    components: { ProductItem },
    props: ['products'],
  };
</script>
