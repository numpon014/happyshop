class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /categories/:category_id/products
  def index
    products = @category.products.paginate(page: params[:page], per_page: 20)

    json_response_with_meta(products, pagination_meta(products))
  end

  # GET /categories/:category_id/products/:id
  def show
    json_response(@product)
  end

  # POST /categories/:category_id/products
  def create
    @category.products.create!(product_params)
    json_response(@category, :created)
  end

  # PUT /categories/:category_id/products/:id
  def update
    @product.update(product_params)
    head :no_content
  end

  # DELETE /categories/:category_id/products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.permit(:name, :sku, :price, :stock)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find_by!(id: params[:id]) if @category
  end
end
