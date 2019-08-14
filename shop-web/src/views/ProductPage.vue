<template>
    <div class="product-page">
        <b-container class="bv-example-row-flex-cols">
            <b-row class="sort-by mt-3">
                <b-col md="3" offset-md="9" align-self="end">
                    <div class="float-left">
                        <span class="align-middle">Sort by</span>
                    </div>
                    <div class="float-right">
                        <b-form-select v-model="sorting.selected"
                                       v-on:change="onSort"
                                       :options="sorting.options"
                                       size="sm"></b-form-select>
                    </div>
                </b-col>
            </b-row>
        </b-container>
        <b-container>
            <b-spinner label="Spinning" v-if='!isFetchProductsSuccess'></b-spinner>
            <ProductList
                    v-if='isFetchProductsSuccess'
                    :products='products'
            ></ProductList>
            <b-pagination size="md"
                          :total-rows="pagination.totalItems"
                          :per-page="pagination.perPage"
                          v-model="pagination.currentPage"
                          @input="fetchProductList(pagination.currentPage)">
            </b-pagination>
        </b-container>
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
        pagination: {
          currentPage: 1,
          perPage: 20,
          totalItems: 0,
        },
       sorting: {
         selected: 'name-asc',
         options: [
           { value: 'name-asc', text: 'Name A-Z' },
           { value: 'name-desc', text: 'Name Z-A' },
           { value: 'price-asc', text: 'Price: Low to High' },
           { value: 'price-desc', text: 'Price: High to Low' },
         ]
       }
      };
    },
    methods: {
      fetchProductList(page) {
        ProductService.getAllProducts({ page }).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
      onSort(e) {
        let sort_column = "name";
        let sort_direction = "asc";
        switch (e) {
          case "name-desc":
            sort_direction = "asc";
            break;
          case "price-asc":
            sort_column = "price";
            sort_direction = "asc";
            break;
          case "price-desc":
            sort_column = "price";
            sort_direction = "desc";
            break;
        }
        ProductService.getAllProducts({ sort_column, sort_direction }).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      }
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
