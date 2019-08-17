<template>
    <div class="product-page">
        <b-container>
            <Header></Header>
        </b-container>
        <b-container class="bv-example-row-flex-cols">
            <b-row class="sort-by mt-3">
                <b-col md="3" offset-md="9">
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
            <b-row class="sort-by mt-3">
                <b-col md="5" offset-md="7">
                    <div class="float-left">
                        <span class="align-middle">Category</span>
                    </div>
                    <div class="float-right">
                        <multiselect v-model="filter.categories.value"
                                     placeholder="Search or add a category"
                                     label="name"
                                     track-by="code"
                                     :options="filter.categories.options"
                                     :multiple="true"
                                     :taggable="true"
                                     @tag="addTag"></multiselect>
                    </div>
                </b-col>
            </b-row>

            <b-row class="filter-price mt-3">
                <b-col md="3" offset-md="9">
                    <vue-slider ref="slider"
                                v-model="filter.priceRange.value"
                                :process="true"
                                :min="filter.priceRange.min"
                                :max="filter.priceRange.max"
                                v-on:drag-end="onPriceFilterChanged"></vue-slider>
                </b-col>
            </b-row>
        </b-container>
        <b-container>
            <b-spinner label="Spinning" v-if='!isFetchProductsSuccess'></b-spinner>
            <ProductList
                    v-if='isFetchProductsSuccess'
                    :products='products'
            ></ProductList>
            <div v-if='pagination.totalItems === 0'>
                No Product found!!
            </div>
            <b-pagination size="md"
                          v-if='pagination.totalItems > 0'
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
  import Header from '../components/Header';

  export default {
    name: 'Product',
    components: {
      ProductList,
      Header,
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
        filter: {
          priceRange: {
            value: [0, 5000],
            max: 5000,
            min: 0,
          },
          categories: {
            value: [
              { name: 'Javascript', code: 'js' }
            ],
            options: [
              { name: 'Vue.js', code: 'vu' },
              { name: 'Javascript', code: 'js' },
              { name: 'Open Source', code: 'os' }
            ],
          },
        },
        sorting: {
          selected: 'name-asc',
          options: [
            {value: 'name-asc', text: 'Name A-Z'},
            {value: 'name-desc', text: 'Name Z-A'},
            {value: 'price-asc', text: 'Price: Low to High'},
            {value: 'price-desc', text: 'Price: High to Low'},
          ],
        },
      };
    },
    methods: {
      addTag(newTag) {
        const tag = {
          name: newTag,
          code: newTag.substring(0, 2) + Math.floor((Math.random() * 10000000)),
        };
        this.options.push(tag);
        this.value.push(tag);
      },
      fetchProductList(page) {
        ProductService.getAllProducts({page}).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
      onPriceFilterChanged() {
        const value = this.$refs.slider.getValue();
        ProductService.getAllProducts({price_from: value[0], price_to: value[1]}).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
      onSort(e) {
        let sort = 'name';
        let direction = 'asc';
        switch (e) {
          case 'name-desc':
            direction = 'asc';
            break;
          case 'price-asc':
            sort = 'price';
            direction = 'asc';
            break;
          case 'price-desc':
            sort = 'price';
            direction = 'desc';
            break;
        }
        ProductService.getAllProducts({sort, direction}).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
    },
    created() {
      this.fetchProductList();
    },
  };
</script>

<style scoped>

</style>
