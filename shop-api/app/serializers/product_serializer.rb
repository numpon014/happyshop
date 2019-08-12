class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :sku, :stock, :image, :description

  belongs_to :category
end
