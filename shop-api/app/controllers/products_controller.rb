class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /categories/:category_id/products
  def index
    products = @category.products.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 20)

    json_response_with_meta(products, pagination_meta(products))
  end

  # GET /categories/:category_id/products/:id
  def show
    json_response(@product)
  end

  # POST /categories/:category_id/products
  def create
    product = @category.products.new(product_params.except(:file))
    product.image = params[:file] # Assign a file like this, or
    product.save!
    json_response(product, :created)
  end

  # PUT /categories/:category_id/products/:id
  def update
    @product.update(product_params)
    json_response(@product)
  end

  # DELETE /categories/:category_id/products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.permit(:name, :sku, :price, :stock, :file, :category_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find_by!(id: params[:id]) if @category
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
