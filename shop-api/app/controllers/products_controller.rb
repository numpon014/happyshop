class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  has_scope :by_price, using: %i[from to], type: :hash, only: :index
  has_scope :sold_out, type: :boolean, only: :index

  # GET /products
  def index
    products = apply_scopes(Product).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 20)

    json_response_with_meta(products, pagination_meta(products))
  end

  # GET /products/:id
  def show
    json_response(@product)
  end

  # POST /products
  def create
    product = Product.new(product_params)
    product.save!
    json_response(product, :created)
  end

  # PUT /products/:id
  def update
    @product.update(product_params)
    json_response(@product)
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.permit(:name, :sku, :price, :stock, :image, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
