import axios from 'axios';

const ApiService = {

  init(baseURL: string | undefined) {
    axios.defaults.baseURL = baseURL;
  },

  get(resource: string) {
    return axios.get(resource);
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
