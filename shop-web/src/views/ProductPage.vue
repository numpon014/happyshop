<template>
    <div>
        <b-container class="header-content">
            <Header></Header>
        </b-container>
        <b-container class="product-page page-content bv-example-row">
            <b-row class="justify-content-end">
                <b-col cols="12" md="auto">
                    <b-form inline>
                        <label class="mr-sm-2 mr-2" for="filter-by-category-input">Category</label>
                        <multiselect v-model="filter.categories.value"
                                     placeholder="Search or add a category"
                                     label="name"
                                     track-by="id"
                                     :limit="2"
                                     :options="filter.categories.options"
                                     :multiple="true"
                                     :loading="isFetchCategoriesLoading"
                                     id="filter-by-category-input"
                                     class="mb-2 mr-sm-2 mb-sm-0"
                                     @input="onCategoryFilterChanged"></multiselect>
                    </b-form>
                </b-col>
                <b-col col md="auto">
                    <b-form inline class="p-sm-4 p-md-2" style="height: 40px">
                        <label class="mr-sm-2 mr-2" for="filter-by-category-input">Price</label>
                        <vue-slider ref="slider"
                                    v-model="filter.priceRange.value"
                                    :process="true"
                                    :min="filter.priceRange.min"
                                    :max="filter.priceRange.max"
                                    style="width: 200px;"
                                    class="mr-sm-2 ml-2"
                                    v-on:drag-end="onPriceFilterChanged"></vue-slider>
                    </b-form>
                </b-col>
                <b-col md="auto">
                    <b-form inline>
                        <label class="mr-sm-2" for="sort-by-input">Sort By</label>
                        <b-form-select v-model="sorting.selected"
                                       v-on:change="onSort"
                                       :options="sorting.options"
                                       id="sort-by-input"></b-form-select>
                    </b-form>
                </b-col>
            </b-row>
        </b-container>
        <b-container>
            <b-row class="justify-content-center" v-if='isFetchProductsLoading' >
                <b-col md="auto" class="p-md-4">
                    <b-spinner label="Spinning"></b-spinner>
                </b-col>
            </b-row>
            <b-row class="justify-content-center" v-if='pagination.totalItems === 0 && !isFetchProductsLoading'>
                <b-col md="auto" class="p-md-4">
                    No Product found!!
                </b-col>
            </b-row>
            <ProductList
                    v-if='!isFetchProductsLoading'
                    :products='products'
            ></ProductList>
            <b-row class="justify-content-end mt-2">
                <b-col md="auto">
                    <b-pagination size="md"
                                  v-if='pagination.totalItems > 0'
                                  :total-rows="pagination.totalItems"
                                  :per-page="pagination.perPage"
                                  v-model="pagination.currentPage"
                                  @input="fetchProducts(pagination.currentPage)">
                    </b-pagination>
                </b-col>
            </b-row>
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
        isFetchProductsLoading: true,
        isFetchCategoriesLoading: true,
        products: [],
        pagination: {
          currentPage: 1,
          perPage: 20,
          totalItems: 0,
        },
        filter: {
          priceRange: {
            value: [0, 10000],
            max: 10000,
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
        const filterParams = this.getFilterValue();
        const params = _.merge({page}, filterParams);
        ProductService.getAllProducts(params).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsLoading = false;
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
        const priceRange = this.$refs.slider ? this.$refs.slider.getValue() : [];
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

        this.isFetchProductsLoading = false;
        ProductService.getAllProducts(params).then((response) => {
          this.products = response.products;
          this.pagination.totalItems = response.meta.total_count;
          this.isFetchProductsLoading = false;
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
    .multiselect {
        width: fit-content;
    }
</style>
