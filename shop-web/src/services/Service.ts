import axios from 'axios';
import qs from 'qs';

const ApiService = {

  init(baseURL: string | undefined) {
    axios.defaults.baseURL = baseURL;
  },

  get(resource: string, params: object) {
    return axios.get(resource, {
      params,
      paramsSerializer(params) {
        return qs.stringify(params, { encode: false });
      },
    });
  },

  post(resource: string, data: any) {
    return axios.post(resource, data);
  },

  put(resource: string, data: any) {
    return axios.put(resource, data);
  },

  delete(resource: string) {
    return axios.delete(resource);
  },

  customRequest(data: any) {
    return axios(data);
  },
};

export default ApiService;
