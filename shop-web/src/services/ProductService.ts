import ApiService from './Service';

const ProductService = {
    async getAllProducts({ page = 1, sort = 'name', direction = 'asc', price_from = 0, price_to = 100000}
    : { page: number; sort: string, direction: string, price_from: number, price_to: number }) {
        try {
            const response = await ApiService.get(`/categories/11/products`,{
                page,
                sort,
                direction,
                by_price: {
                    from: price_from,
                    to: price_to,
                },
            } );
            return response.data;
        } catch (error) {
            throw new Error(error.response);
        }
    },
};

export default ProductService;

export {ProductService};
