<template>
    <b-row>
        <ProductItem
                v-for="product in this.products"
                v-bind:key="`product-item-${product.id}`"
                :product="product"
        ></ProductItem>
    </b-row>
</template>

<script>
  import ProductItem from './ProductItem';

  export default {
    name: 'ProductList',
    components: {ProductItem},
    props: ['products'],
  };
</script>
