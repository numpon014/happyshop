<template>
    <div class="product-page">
        <b-container>
            <Header></Header>
        </b-container>
        <b-container class="bv-example-row-flex-cols">
            <b-row class="sort-by mt-3">
                <b-col md="3" offset-md="9">
                    <div class="float-right">
                        <div class="d-inline-block mr-3">
                            <span class="align-middle">Sort by</span>
                        </div>
                        <div class="d-inline-block">
                        <b-form-select v-model="sorting.selected"
                                       v-on:change="onSort"
                                       :options="sorting.options"
                                       size="sm"></b-form-select>
                        </div>
                    </div>
                </b-col>
            </b-row>
            <b-row class="sort-by mt-3">
                <b-col md="7" offset-md="5">
                    <div class="float-right">
                        <div class="d-inline-block mr-3">
                            <span class="align-middle">Category</span>
                        </div>
                        <div class="d-inline-block">
                            <multiselect v-model="filter.categories.value"
                                         placeholder="Search or add a category"
                                         label="name"
                                         track-by="id"
                                         :limit="3"
                                         :options="filter.categories.options"
                                         :multiple="true"
                                         :taggable="true"
                                         :loading="isFetchCategoriesLoading"
                                         @input="onCategoryFilterChanged"></multiselect>
                        </div>
                    </div>
                </b-col>
            </b-row>

            <b-row class="filter-price mt-3">
                <b-col md="1" offset-md="8" class="text-right">
                    <span class="align-top text-right">Price</span>
                </b-col>
                <b-col md="3">
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
  import CategoryService from '../services/CategoryService';
  import ProductList from '../components/product/ProductList';
  import _ from 'lodash';
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
        isFetchCategoriesLoading: true,
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
            value: [],
            options: [],
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
      fetchProducts(page) {
        ProductService.getAllProducts({page}).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
      fetchCategories() {
        this.isFetchCategoriesLoading = true;
        CategoryService.getAllCategory().then((response) => {
          this.filter.categories.options = response.map((item) => { return { id : item.id, name : item.name } });
          this.isFetchCategoriesLoading = false;
        });
      },
      getFilterValue() {
        let sort = 'name';
        let direction = 'asc';
        switch (this.sorting.selected) {
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
        const priceRange = this.$refs.slider.getValue();
        const category_ids = _.map(this.filter.categories.value, 'id');

        return {
          price_from: priceRange[0],
          price_to: priceRange[1],
          by_categories: category_ids,
          sort,
          direction
        }
      },
      filterProducts() {
        const params = this.getFilterValue();

        this.isFetchProductsSuccess = false;
        ProductService.getAllProducts(params).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsSuccess = true;
        });
      },
      onPriceFilterChanged() {
        this.filterProducts()
      },
      onCategoryFilterChanged() {
        this.filterProducts();
      },
      onSort() {
        this.filterProducts();
      },
    },
    created() {
      this.fetchProducts();
      this.fetchCategories();
    },
  };
</script>

<style scoped>

</style>
