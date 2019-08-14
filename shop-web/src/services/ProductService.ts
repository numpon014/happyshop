import ApiService from './Service';

const ProductService = {
    // tslint:disable-next-line:max-line-length
    async getAllProducts({page = 1, sort_column = 'name', sort_direction = 'asc'}: { page: number; sort_column: string, sort_direction: string }) {
        const requestData = {
            method: 'get',
            url: `/categories/11/products?page=${page}&sort=${sort_column}&direction=${sort_direction}`,
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

export {ProductService};
