<template>
    <b-col sm="3" class="py-2">
        <b-card
                no-body
                img-alt="Image"
                img-top
                class="mb-3 h-100">
            <img src="@/assets/fa-image.png" class="card-img" v-if="!product.image.url"/>
            <b-card-img :src="product.image.url" v-if="product.image.url"/>
            <b-card-body>
                <b-card-text class="title">{{product.name}}</b-card-text>
                <b-card-text>{{product.description}}</b-card-text>
            </b-card-body>
            <div slot="footer">
                <small class="text-muted">{{product.price}}$</small>
            </div>
        </b-card>
    </b-col>
</template>

<script>
  export default {
    name: 'ProductItem',
    props: ['product'],
  };
</script>

<style scoped>
    .title {
        font-weight: bold;
    }
</style>
