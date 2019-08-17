import ApiService from './Service';

const ProductService = {
    async getAllProducts({ page = 1, sort = 'name', direction = 'asc', price_from = 0, price_to = 100000, by_categories = []}
    : { page: number; sort: string, direction: string, price_from: number, price_to: number, by_categories: number[] }) {
        try {
            const response = await ApiService.get(`/products`, {
                page,
                sort,
                direction,
                by_price: {
                    from: price_from,
                    to: price_to,
                },
                by_categories,
            } );
            return response.data;
        } catch (error) {
            throw new Error(error.response);
        }
    },
};

export default ProductService;

export {ProductService};
