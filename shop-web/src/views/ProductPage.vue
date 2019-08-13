<template>
  <div class="page-container">
      <ProductList
          v-if='isFetchProductsSuccess'
          :products = 'products'
      ></ProductList>
  </div>
</template>

<script>
  import ProductService from '../services/ProductService';
  import ProductList from '../components/product/ProductList';

  export default {
    name: 'Product',
    components: {
      ProductList,
    },
    data() {
      return {
        isFetchProductsSuccess: false,
        products: [],
      };
    },
    methods: {
      fetchProductList() {
        ProductService.getAllProducts().then((response) => {
          this.products = response.products;
          this.isFetchProductsSuccess = true;
        });
      }
    },
    created() {
      this.fetchProductList();
    },
    mounted() {
    },
  };
</script>

<style scoped>

</style>
