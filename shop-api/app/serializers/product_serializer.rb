class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :sku, :stock, :image, :description

  has_many :categories
end
