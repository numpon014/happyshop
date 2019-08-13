import ApiService from './Service';

const ProductService = {
  async getAllProducts() {
    const requestData = {
      method: 'get',
      url: `/categories/7/products?page=1&sort=price`,
    };

    try {
      const response = await ApiService.customRequest(requestData);
      return response.data;
    } catch (error) {
      throw new Error(error.response);
    }
  },
};

export default ProductService;

export { ProductService };
