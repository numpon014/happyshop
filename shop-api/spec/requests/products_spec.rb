require 'rails_helper'
require 'byebug'

RSpec.describe 'Products API' do
  # Initialize the test data
  let!(:category) { create(:category) }
  let!(:products) { create_list(:product, 40, categories: [category]) }
  let(:category_id) { category.id }
  let(:id) { products.first.id }
  let(:second_page_first_product_id) { Product.order(:name)[20].id }

  # Test suite for GET /products
  describe 'GET /products' do
    # make HTTP get request before each example
    before { get '/products' }

    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["products"]).not_to be_empty
      expect(json["products"].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /products?page=2' do
    before { get "/products?page=2" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns category products amount' do
        expect(json['products'].size).to eq(20)
      end

      it 'returns category products amount' do
        expect(json['products'][0]['id']).to eq(second_page_first_product_id)
      end
    end
  end

  # Test suite for GET /products/:id
  describe 'GET /products/:id' do
    before { get "/products/#{id}" }

    context 'when category product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the product' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for POST /products
  describe 'POST /products' do
    let(:valid_attributes) { { name: 'Visit Narnia', price: 1000, sku: '1111111', stock: 100 } }

    context 'when request attributes are valid' do
      before { post "/products", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/products", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /products/:id
  describe 'PUT /products/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/products/#{id}", params: valid_attributes }

    context 'when product exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end

      it 'updates the product' do
        updated_product = Product.find(id)
        expect(updated_product.name).to match(/Mozart/)
      end
    end

    context 'when the product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for DELETE /products/:id
  describe 'DELETE /products/:id' do
    before { delete "/products/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end