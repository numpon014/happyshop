<template>
    <b-container class="bv-example-row">
        <ProductList
                v-if='isFetchProductsSuccess'
                :products='products'
        ></ProductList>
        <b-pagination size="md"
                      :total-rows="totalItems"
                      :per-page="perPage"
                      v-model="currentPage"
                      @input="fetchProductList(currentPage)">
        </b-pagination>
    </b-container>
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
        currentPage: 1,
        perPage: 20,
        totalItems: 0
      };
    },
    methods: {
      fetchProductList(page) {
        ProductService.getAllProducts(page).then((response) => {
          this.products = response.products;
          this.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
    },
    created() {
      this.fetchProductList(1);
    },
    mounted() {
    },
  };
</script>

<style scoped>

</style>
