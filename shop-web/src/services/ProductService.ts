import ApiService from './Service';

const ProductService = {
  async getAllProducts(page: number) {
    const requestData = {
      method: 'get',
      url: `/categories/11/products?page=${page}&sort=price`,
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
