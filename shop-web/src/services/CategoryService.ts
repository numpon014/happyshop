import ApiService from './Service';

const CategoryService = {
    async getAllCategory() {
        const requestData = {
            method: 'get',
            url: `/categories`,
        };
        try {
            const response = await ApiService.customRequest(requestData);
            return response.data;
        } catch (error) {
            throw new Error(error.response);
        }
    },
};

export default CategoryService;

export {CategoryService};
